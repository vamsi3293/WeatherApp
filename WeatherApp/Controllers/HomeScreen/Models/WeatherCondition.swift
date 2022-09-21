//
//  WeatherCondition.swift
//  WeatherApp
//
//  Created by inlusr1 on 20/09/22.
//

import Foundation


struct WeatherCondition:Codable{
	let text:String
	let icon:String
}
struct DayWeather:Codable{
	let maxtemp_c:Float
	let mintemp_c:Float
	let condition:WeatherCondition
}
struct DayForecast:Codable{
	let date:String
	let day:DayWeather
}
struct Forecast:Codable{
	let forecastday :[DayForecast]
}

struct Location:Codable{
	let name:String
	let country:String
	let region:String
	let localtime:String
}

struct ForecastModel:Codable{
	let forecast:Forecast
	let location:Location
}
