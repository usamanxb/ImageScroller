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
        DispatchQueue.global(qos: .background).async {
            for a in self.urlString{
                self.loadImage(url: a)
            }
        }
    }

    
    func loadImage(url:String) {
//        if loadImageFromCache(url: url) {
//            print("Cache hit")
//            return
//        }
//        
//        print("Cache miss, loading from url")
        loadImageFromUrl(url: url)
    }
    
    func loadImageFromCache(url:String) -> Bool {
//        guard let urlString = urlString else {
//            return false
//        }
        
        guard let cacheImage = imageCache.get(forKey: url) else {
            return false
        }
        image.append(cacheImage)
        //image = cacheImage
        return true
    }
    
    func loadImageFromUrl(url:String) {
//        guard let urlString = urlString else {
//            return
//        }
        self.imageUrl = url
        let url = URL(string: url)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
    }
    
    
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard let data = data else {
            print("No data found")
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            
            self.imageCache.set(forKey: self.imageUrl, image: loadedImage)
//            self.image = loadedImage
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
