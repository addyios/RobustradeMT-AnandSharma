//
//  ImageLoader.swift
//  RobustradeMT-AnandSharma
//
//  Created by APPLE on 03/01/26.
//

import Foundation

import UIKit

final class ImageLoader {

    static let shared = ImageLoader()
    private init() {}

    private let cache = NSCache<NSString, UIImage>()

    func load(
        urlString: String,
        into imageView: UIImageView,
        placeholder: UIImage = UIImage(named: "Image_not_available")!
    ) {
        imageView.image = placeholder

        guard let url = URL(string: urlString), !urlString.isEmpty else {
            return
        }
        
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            imageView.image = cachedImage
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self, weak imageView] data, _, error in
            guard
                let self = self,
                let imageView = imageView,
                let data = data,
                error == nil,
                let image = UIImage(data: data)
            else {
                return
            }
            self.cache.setObject(image, forKey: urlString as NSString)

            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()
    }
}

