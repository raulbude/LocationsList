//
//  DetailedLocationViewController.swift
//  LocationsList
//
//  Created by Raul Bude on 12.01.2021.
//

import UIKit
import SnapKit

final class DetailedLocationViewController: UIViewController {
    // MARK: - Properties
    
    private let viewModel: DetailedLocationViewModel
    private let addressLabel = UILabel()
    private let labelLabel = UILabel()
    private let latitudeLabel = UILabel()
    private let longitudeLabel = UILabel()
    
    // MARK: - Init
    
    init(viewModel: DetailedLocationViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        view.backgroundColor = .darkGray
        view.addSubview(labelLabel)
        labelLabel.numberOfLines = 0
        labelLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        labelLabel.textColor = .yellow
        labelLabel.textAlignment = .center
        labelLabel.text = "Label: \(viewModel.label ?? "")"
        labelLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(CGFloat.f100)
            $0.leading.trailing.equalToSuperview().inset(CGFloat.f20)
        }
        
        view.addSubview(addressLabel)
        addressLabel.numberOfLines = 0
        addressLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        addressLabel.textColor = .brown
        addressLabel.textAlignment = .center
        addressLabel.text = "Address: \(viewModel.address ?? "")"
        addressLabel.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.leading.trailing.equalTo(self.labelLabel)
            $0.top.equalTo(labelLabel.snp.bottom).offset(CGFloat.f100)
        }
        
        view.addSubview(latitudeLabel)
        latitudeLabel.numberOfLines = 0
        latitudeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        latitudeLabel.textColor = .yellow
        latitudeLabel.textAlignment = .left
        latitudeLabel.text = "Latitude: \(viewModel.latitude ?? 0)"
        latitudeLabel.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.leading.equalToSuperview().offset(CGFloat.f20)
            $0.width.equalTo(self.view.frame.size.width / 2)
            $0.bottom.equalToSuperview().offset(-CGFloat.f100)
        }
        
        view.addSubview(longitudeLabel)
        longitudeLabel.numberOfLines = 0
        longitudeLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        longitudeLabel.textColor = .yellow
        longitudeLabel.textAlignment = .right
        longitudeLabel.text = "Latitude: \(viewModel.longitude ?? 0)"
        longitudeLabel.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.trailing.equalToSuperview().offset(-CGFloat.f20)
            $0.bottom.width.equalTo(self.latitudeLabel)
        }
    }
}
