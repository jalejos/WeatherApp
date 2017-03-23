//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Alejos on 3/20/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherService {
    
    static let sharedInstance = WeatherService()
    
    var currentWeather: Weather? = nil
    
    func getWeather (geolocation: Geolocation, onComplete: @escaping (_ weather: Weather?, _ error: Error?) -> Void) {
        WeatherRepository.getWeather(geolocation: geolocation) { (responseJSON, error) in
            if responseJSON != nil {
                let weather = Mapper<Weather>().map(JSONObject: responseJSON)
                self.currentWeather = weather
                onComplete(weather, nil)
            } else {
                onComplete(nil, error)
            }
        }
    }
    
    func getForecast (geolocation: Geolocation, onComplete: @escaping (_ weather: [Forecast]?, _ error: Error?) -> Void) {
        WeatherRepository.getForecast(geolocation: geolocation) { (responseJSON, error) in
            if responseJSON != nil {
                guard let arrayJSON = responseJSON!["list"] as? Array<Dictionary<String, Any>> else {
                    onComplete(nil, nil);
                    return
                }
                let forecastArray = Mapper<Forecast>().mapArray(JSONArray: arrayJSON)
                onComplete(forecastArray, error)
            } else {
                onComplete(nil, error)
            }
        }
    }
    
    func getIcon (identifier: String, onComplete: @escaping (_ icon: UIImage?, _ error: Error?) -> Void) {
        WeatherRepository.getIcon(identifier: identifier) { (icon, error) in
            if let icon = icon {
                onComplete(icon, nil)
            } else {
                onComplete(nil, error)
            }
        }
    }
}
