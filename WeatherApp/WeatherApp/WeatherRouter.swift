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
    static let celsiusUnits = "metric"
    static let farenheitUnits = "imperial"
    
    enum TemperatureUnits {
        case celsiusUnits, farenheitUnits, kelvinUnits
    }
    
    static func getWeatherRequest(geolocation: Geolocation, units: TemperatureUnits) -> String {
        let unitParam : String
        
        switch units {
        case .celsiusUnits:
            unitParam = "&units=\(celsiusUnits)"
            break
        case .farenheitUnits:
            unitParam = "&units=\(farenheitUnits)"
            break
        case .kelvinUnits:
            unitParam = ""
            break
        }
        
        return baseURL + "?lat=\(geolocation.latitude)&lon=\(geolocation.longitude)&appid=\(appId)" + unitParam
    }
}
