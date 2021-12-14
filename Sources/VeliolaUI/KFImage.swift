//
//  File.swift
//  
//
//  Created by Tadreik Campbell on 10/16/21.
//

import UIKit
import Kingfisher

extension UIImageView {
    func kfImage(_ url: String) {
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: URL(string: url),
            placeholder: .none,
            options: [
                .scaleFactor(1),
                .transition(.fade(0.2)),
                .cacheOriginalImage
            ])
    }
}
