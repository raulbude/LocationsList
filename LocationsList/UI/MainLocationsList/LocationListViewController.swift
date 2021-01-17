//
//  LocationListViewController.swift
//  LocationsList
//
//  Created by Raul Bude on 12.01.2021.
//

import UIKit
import SnapKit

class LocationListViewController: UIViewController {
    // MARK: - Properties
    
    private let viewModel: LocationListViewModel
    private var presenter: LocationListPresenter
    private let pagerView = FSPagerView(frame: .zero)
    
    // MARK: - Init
    
    init(viewModel: LocationListViewModel, presenter: LocationListPresenter) {
        self.viewModel = viewModel
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        
        self.presenter.view = self
        self.presenter.locationAccessUpdate = { [weak self] in
            self?.reloadWithLocationAccess($0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.register(LocationListViewCell.self, forCellWithReuseIdentifier: "locationCell")
        view.addSubview(pagerView)
        pagerView.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(CGFloat.f100)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-CGFloat.f100)
        }
    }
    
    private func reloadWithLocationAccess(_ access: Bool) {
        guard !access else { return }
        let alert = UIAlertController(title: nil,
                                      message: "This app requires your permission to use the location services to determine your location.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Allow", style: .cancel) { _ in
            guard let bundleID = Bundle.main.bundleIdentifier, let url = URL(string: UIApplication.openSettingsURLString + bundleID) else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
        alert.addAction(UIAlertAction(title: "Don't Allow", style: .`default`, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - FSPagerViewDataSource

extension LocationListViewController: FSPagerViewDataSource {
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "locationCell", at: index)
        guard let locationCell = (cell as? LocationListViewCell) else { return cell }
        locationCell.viewModel = viewModel.cellsVM[index]
        return locationCell
    }

    func numberOfItems(in pagerView: FSPagerView) -> Int {
        viewModel.cellsVM.count
    }
}

// MARK: - FSPagerViewDelegate

extension LocationListViewController: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        presenter.didSelectItemWithLabel(viewModel.cellsVM[index].label)
    }
}

// MARK: - LocationListViewProtocol

extension LocationListViewController: LocationListViewProtocol {
    func didReceiveLocations() {
        DispatchQueue.main.async { [weak self] in
            self?.pagerView.reloadData()
        }
    }
    
    func didFailToReceiveLocations(with error: String) {
        let alert = UIAlertController(title: "Can't get locations",
                                      message: error,
                                      preferredStyle: .alert)
        present(alert, animated: true, completion: nil)
    }
}

