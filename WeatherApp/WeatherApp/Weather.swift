//
//  Weather.swift
//  WeatherApp
//
//  Created by Alejos on 3/20/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit
import ObjectMapper

class Weather: Mappable {
    var celcius: Double = 0
    var location: String = "0"
    var description: String = ""
    var sunrise: Date = Date()
    var sunset: Date = Date()
    
    let transformCelcius = TransformOf<Double, Double>(fromJSON: { (value: Double?) -> Double? in
        // transform value from Kelvin to Celcius
        if let value = value {
            return Double(value) - 273.15
        }
        return nil
    }, toJSON: { (value: Double?) -> Double? in
        // transform value from Celcius to Kelvin
        if let value = value {
            return Double(value) + 273.15
        }
        return nil
    })
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        celcius <- (map["main.temp"], transformCelcius)
        location <- map["name"]
        description <- map["weather.description"]
        sunrise <- (map["sys.sunrise"], DateTransform())
        sunset <- (map["sys.sunset"], DateTransform())
    }
}
