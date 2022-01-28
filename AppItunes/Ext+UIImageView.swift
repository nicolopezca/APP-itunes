//
//  Ext+UIImageView.swift
//  AppItunes
//
//  Created by Nicolás López Cano on 14/1/22.
//

import UIKit

extension UIImageView {
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
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
