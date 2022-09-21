//
//  ImageViewExtension.swift
//  WeatherApp
//
//  Created by inlusr1 on 20/09/22.
//


import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
let cachedImages = NSCache<NSString, UIImage>()

extension UIImageView {
	func loadImageFromURL(url: String) {
		self.image = nil
		//check valid url
		guard let URL = URL(string: url) else {
			print("No Image For this url", url)
			return
		}
		//check for cached image
		if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
			self.image = cachedImage
			return
		}
		//download image from url
		DispatchQueue.global().async { [weak self] in
			if let data = try? Data(contentsOf: URL) {
				if let image = UIImage(data: data) {
					let imageTocache = image
					imageCache.setObject(imageTocache, forKey: url as AnyObject)
					
					DispatchQueue.main.async {
						self?.image = imageTocache
					}
				}
			}
		}
		
	}
	

}

