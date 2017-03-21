//
//  WeatherRouter.swift
//  WeatherApp
//
//  Created by Alejos on 3/21/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation

struct WeatherRouter {
    
    static let baseURL = "http://api.openweathermap.org/data/2.5/weather"
    static let appId = "3f3a608541a999f9d309a7f2b3f36ac7"
    
    enum TemperatureUnits : String {
        case celsius = "metric"
        case farenheit = "imperial"
        case kelvin = ""
    }
    
    static func getWeatherRequest(geolocation: Geolocation, units: TemperatureUnits) -> String {
        let unitParam : String
        
        switch units {
        case .celsius:
            unitParam = "&units=\(units.rawValue)"
            break
        case .farenheit:
            unitParam = "&units=\(units.rawValue)"
            break
        case .kelvin:
            unitParam = ""
            break
        }
        
        return baseURL + "?lat=\(geolocation.latitude)&lon=\(geolocation.longitude)&appid=\(appId)" + unitParam
    }
}
