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
    
    var viewModel: LocationListCellViewModel? {
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
            $0.width.height.equalTo(CGFloat.f250)
            $0.center.equalToSuperview()
        }
        locationImageView.contentMode = .scaleAspectFill
        locationImageView.setThumbnail(for: viewModel?.locationImageStringUrl ?? "")
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(CGFloat.f10)
            $0.trailing.equalToSuperview().offset(-CGFloat.f10)
        }
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        titleLabel.textColor = .yellow
        titleLabel.textAlignment = .center
        titleLabel.text = "Address: \(viewModel?.label ?? "")"
        
        addSubview(distanceLabel)
        distanceLabel.snp.makeConstraints { [weak self] in
            guard let self = self else { return }
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(CGFloat.f20)
            $0.leading.trailing.equalTo(self.titleLabel)
        }
        distanceLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        distanceLabel.textColor = .brown
        distanceLabel.textAlignment = .center
        guard viewModel?.distance == -1 else {
            distanceLabel.text = "Distance: \(String(format:"%.02f", (viewModel?.distance ?? 0))) km"
            return
        }
        distanceLabel.text = "Can't calculate the distance."
    }
}
