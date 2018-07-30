//
//  ImageCacher.swift
//  ItunesSearch
//
//  Created by Michael Aidoo on 2018-07-29.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation
import UIKit

public protocol Cachable {}

extension UIImageView: Cachable {}

public let imageCache = NSCache<NSString, UIImage>()

extension Cachable where Self: UIImageView {
    typealias completionHandler = ((Bool) -> ())
    
    func loadImageCache(with urlString: String, completion: completionHandler?) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            DispatchQueue.main.async {
                self.image = cachedImage
                completion?(true)
            }
            return
        }
        if let url = URL.init(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    completion?(false)
                    return
                }
                if let data = data {
                    if let image = UIImage(data: data) {
                        imageCache.setObject(image, forKey: NSString.init(string: urlString))
                        DispatchQueue.main.async {
                            self.image = image
                            completion?(true)
                        }
                    }
                }
            }).resume()
        }
    }
}
