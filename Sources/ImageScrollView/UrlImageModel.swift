//
//  UrlImageModel.swift
//  NewsApp
//
//  Created by SchwiftyUI on 12/29/19.
//  Copyright © 2019 SchwiftyUI. All rights reserved.
//

import Foundation
import SwiftUI

class UrlImageModel: ObservableObject {
    @Published var image: [UIImage] = []
    @Published var images : [[UIImage]] = []
    var downloadedImages : [UIImage] = []
    var urlString: [String]
    var imageUrl : String = ""
    var imageCache = ImageCache.getImageCache()
    
    init(urlString: [String]) {
        self.urlString = urlString
        downloadImages(urlString: urlString)
    }

    func downloadImages(urlString: [String]){
        DispatchQueue.global(qos: .background).async {
            for urls in self.urlString{
                self.imageUrl = urls
                guard let url = URL(string: urls) else {return}
                let task = URLSession.shared.dataTask(with: url, completionHandler: self.getImageFromResponse(data:response:error:))
                task.resume()
            }
        }
    }
    
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            self.image.append(UIImage(systemName: "circle")!)
            self.images = self.image.chunked(into: 3)
            return
        }
        guard let data = data else {
            print("No data found")
            self.image.append(UIImage(systemName: "circle")!)
            self.images = self.image.chunked(into: 3)
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                self.image.append(UIImage(systemName: "circle")!)
                self.images = self.image.chunked(into: 3)
                return
            }
            
            if let url = response?.url?.absoluteString {
                self.imageUrl = url
            }
            self.imageCache.set(forKey: self.imageUrl, image: loadedImage)
            self.downloadedImages.append(loadedImage)
            self.image.append(loadedImage)
            self.images = self.image.chunked(into: 3)
        }
    }
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
