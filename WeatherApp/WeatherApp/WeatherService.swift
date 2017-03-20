//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Alejos on 3/20/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation

struct WeatherService {
    static func getWeather (location: Geolocation, onClosure: @escaping (_ weather: Weather?, _ error: Error?) -> Void) {
        WeatherRepository.getWeather(location: location) { (weatherJSON, error) in
            if (error != nil){
                onClosure (nil, nil)
            } else {
                onClosure (nil, error)
            }
        }
    }
}
