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
    
    private let pagerView = FSPagerView(frame: .zero)
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        // ----
        let label = UILabel()
        label.text = "Start"
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        // ----
//        pagerView.dataSource = self
        // register Cell
//        view.addSubview(pagerView)
//        pagerView.snp.makeConstraints { [weak self] in
//            guard let self = self else { return }
//            $0.leading.trailing.equalToSuperview()
//            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
//            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
//        }
    }
}

// MARK: - FSPagerViewDataSource

//extension LocationListViewController: FSPagerViewDataSource {
//    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
//
//    }
//
//    func numberOfItems(in pagerView: FSPagerView) -> Int {
//
//    }
//}
