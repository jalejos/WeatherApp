//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Alejos on 3/20/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation
import ObjectMapper

struct WeatherService {
    static func getWeather (geolocation: Geolocation, onClosure: @escaping (_ weather: Weather?, _ error: Error?) -> Void) {
        WeatherRepository.getWeather(geolocation: geolocation) { (weatherJSON, error) in
            if (error == nil){
                guard let weatherJSON = weatherJSON else {onClosure(nil, nil); return}

                if let weather = Mapper<Weather>().map(JSONObject: weatherJSON) {
                    onClosure (weather, nil)
                } else {
                    onClosure (nil, nil)
                }
                onClosure(nil, nil)
            } else {
                onClosure (nil, error)
            }
        }
    }
    
    static func getForecast (geolocation: Geolocation, onClosure: @escaping (_ weather: [Weather]?, _ error: Error?) -> Void) {
        WeatherRepository.getForecast(geolocation: geolocation) { (responseJSON, error) in
            if error == nil {
                guard let responseJSON = responseJSON else { onClosure(nil, nil); return }
                guard let arrayJSON = responseJSON["list"] as? Array<Dictionary<String, Any>> else { onClosure(nil, nil); return }
                
                if let weatherArray = Mapper<Weather>().mapArray(JSONArray: arrayJSON) {
                    onClosure(weatherArray, nil)
                }
                
            }
        }
    }
}
