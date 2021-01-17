//
//  UIImageView+Extensions.swift
//  LocationsList
//
//  Created by Raul Bude on 15.01.2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setThumbnail(for stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        let placeHolder = UIImage(systemName: "star.fill")
        self.kf.setImage(with: url, placeholder: placeHolder, options: [.forceRefresh, .keepCurrentImageWhileLoading]) {
            print("Kingfisher result: \($0)")
        }
    }
}
