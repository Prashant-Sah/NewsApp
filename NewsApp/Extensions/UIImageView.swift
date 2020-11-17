//
//  UIImageView.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/16/20.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImageWithUrlString(string: String, placeholder: UIImage? = nil) {
        guard let url = URL(string: string) else { self.image = placeholder; return }
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: placeholder)
    }

}
