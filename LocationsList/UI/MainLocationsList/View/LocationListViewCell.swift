//
//  LocationListViewCell.swift
//  LocationsList
//
//  Created by Raul Bude on 13.01.2021.
//

import UIKit
import SnapKit

final class LocationListViewCell: FSPagerViewCell {
    // MARK: - Properties
    
    private var viewModel: LocationListCellViewModel? {
        didSet {
            subviews.forEach {
                $0.snp.removeConstraints()
                $0.removeFromSuperview()
            }
            setupUI()
        }
    }
    private let locationImageView = UIImageView()
    private let titleLabel = UILabel()
    private let distanceLabel = UILabel()
    
    // MARK: - Private Functions
    
    private func setupUI() {
        addSubview(locationImageView)
        locationImageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(CGFloat.f150)
        }
        locationImageView.image = viewModel?.locationImage
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.leading.equalTo(self.locationImageView.snp.trailing).offset(CGFloat.f10)
            $0.trailing.equalToSuperview().offset(-CGFloat.f10)
        }
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.text = "Address: \(viewModel?.address ?? "")"
        
        addSubview(distanceLabel)
        distanceLabel.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(CGFloat.f20)
            $0.leading.trailing.equalTo(self.titleLabel)
        }
        distanceLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        distanceLabel.textColor = .brown
        distanceLabel.textAlignment = .center
        // add meter or km for distance
        distanceLabel.text = "Distance: \(viewModel?.distance ?? 0)"
    }
}
