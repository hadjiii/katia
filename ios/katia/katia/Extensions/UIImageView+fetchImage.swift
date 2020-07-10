//
//  UIImageView+fetchImage.swift
//  katia
//
//  Created by Hadji on 09/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit
import Photos

extension UIImageView{
    func fetchImage(asset: PHAsset, contentMode: PHImageContentMode, targetSize: CGSize) {
        let options = PHImageRequestOptions()
        options.version = .original
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { image, _ in
            guard let image = image else { return }
            switch contentMode {
            case .aspectFill:
                self.contentMode = .scaleAspectFill
            case .aspectFit:
                self.contentMode = .scaleAspectFit
            @unknown default:
                fatalError()
            }
            self.image = image
        }
    }
}
