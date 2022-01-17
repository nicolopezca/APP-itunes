//
//  Ext+UIImageView.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 14/1/22.
//

import UIKit

extension UIImageView {
    static let imageCache = NSCache<AnyObject, AnyObject>()
//    @discardableResult
//    public func loadImage(url: URL, placeholder: UIImage? = nil, completion:(() -> Void)? = nil) -> URLSessionDataTask? {
////        if let cacheImage = UIImageView.imageCache.object(forKey: url as AnyObject) as? UIImage {
////            self.image = cacheImage
////            DispatchQueue.main.async {
////                completion?()
////            }
////            return nil
////        }
////        self.image = placeholder
////
////        return self.loadImage(url: url, completion: completion)
//    }
    
    public func loadImageFromUrl(url: URL, completion:(() -> Void)? = nil ) -> URLSessionDataTask? {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard error == nil, let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion?()
                }
                return
            }
            UIImageView.imageCache.setObject(image, forKey: url as AnyObject)
            DispatchQueue.main.async {
                self?.image = image
                completion?()
            }
        }
        task.resume()
        return task
    }
}
