//
//  ForecastVM.swift
//  WeatherApp
//
//  Created by inlusr1 on 20/09/22.
//

import Foundation
import UIKit
class ForecastVM : NSObject{
	private var weatherForecastService:WeatherForecastServiceProtocol
	var reloadData: (() -> Void)?
	var forecastData:ForecastModel?
	/// initializes the view model with protocol WeatherForecastService
	/// - Parameters
	///    - service: WeatherForecastServiceProtocol represents api methods used to get forecast data
	init(service: WeatherForecastServiceProtocol = WeatherForecastService()) {
		self.weatherForecastService = service
	}
	/// gets theforecast data from userdefaults if exists or from rest api
	func getForecastDataFromDefaults(){
		let currentDate = Date.getCurrentDate()
		if let data = UserDefaults.standard.data(forKey: currentDate){
			do {
				   let decoder = JSONDecoder()
				self.forecastData = try decoder.decode(ForecastModel.self, from: data)
				self.reloadData?()

			   } catch {
				   print("Unable to Decode data (\(error))")
			   }
		}else{
			getWeatherForecastData()
		}
	}
	/// gets the forecast data from rest api
	func getWeatherForecastData(){

		weatherForecastService.getSevenDaysWeatherForecast { success, forecast, error in
			
			if(success){
				guard let forecastData = forecast else{return}
				self.forecastData = forecastData
				self.reloadData?()
				
			}else{
				guard let error = error else{
					return
				}
				GLOBAL.sharedInstance.showAlert(title: "Error", message: error, completionHandler: nil)
				
			}
			
			
		}
	}

}
