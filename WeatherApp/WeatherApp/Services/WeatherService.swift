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
    
    //MARK: Singleton
    static let sharedInstance = WeatherService()
    
    //MARK: Variables
    var currentWeather: Weather?
    
    //MARK: Get requests
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
                var forecastArray = Mapper<Forecast>().mapArray(JSONArray: arrayJSON)
                //API returns 6 elements including today, so we got to remove the first element of the array
                forecastArray?.remove(at: 0)
                onComplete(forecastArray, error)
            } else {
                onComplete(nil, error)
            }
        }
    }
    
}
