//
//  WeatherForecastService.swift
//  WeatherApp
//
//  Created by inlusr1 on 20/09/22.
//

import Foundation


protocol WeatherForecastServiceProtocol{
	
	func getSevenDaysWeatherForecast(completion:@escaping (_ success:Bool,_ forecast:ForecastModel?,_ error:String?) -> ())
}
class WeatherForecastService:WeatherForecastServiceProtocol{
	func getSevenDaysWeatherForecast(completion: @escaping (Bool, ForecastModel?, String?) -> ()) {
		HttpClient().GET(url: APIUrl.baseUrl, params: nil, options: nil) { success, data in
			if success {
				do {
					//decodes data to model object
					let forecastModel = try JSONDecoder().decode(ForecastModel.self, from: data!)
					// stores data for persistancy
					UserDefaults.standard.set(data!, forKey: Date.getCurrentDate())
					//sends the data to calling object
					completion(true, forecastModel, nil)
				} catch {
					completion(false,nil, APIErrorDescription.JsonParseError)
				}
			}
			
		}
		
	}
	
}
