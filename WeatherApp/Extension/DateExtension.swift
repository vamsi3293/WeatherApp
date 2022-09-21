//
//  DateExtension.swift
//  WeatherApp
//
//  Created by inlusr1 on 21/09/22.
//

import Foundation
extension Date {
//extension method for getting date string
 static func getCurrentDate() -> String {

		let dateFormatter = DateFormatter()

		dateFormatter.dateFormat = "dd/MM/yyyy"

		return dateFormatter.string(from: Date())

	}
	//extension method for getting date and time string
	static func getCurrentDateAndTime() -> String {

		   let dateFormatter = DateFormatter()

		   dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"

		   return dateFormatter.string(from: Date())

	   }
}

