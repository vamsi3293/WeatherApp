//
//  GLOBAL.swift
//  WeatherApp
//
//  Created by inlusr1 on 20/09/22.
//


import Foundation
import UIKit

class GLOBAL : NSObject{
	var vSpinner : UIView?
	//sharedInstance
	static let sharedInstance = GLOBAL()
	
	func showAlert(title:String,message:String,bttonTitle:String?="OK",completionHandler: (() -> Void)?){
		
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		alert.addAction(UIAlertAction(title: bttonTitle, style: .destructive, handler: { action in
			if let completion = completionHandler{
				completion()
			}
			
		}))
		let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
		let viewController = window?.rootViewController
		DispatchQueue.main.async {
			viewController?.present(alert, animated: true, completion: nil)
		}
		
	}
}
