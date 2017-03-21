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
    var temperature: Int = 0
    var location: String = "0"
    var description: String = ""
    var sunrise: Date = Date()
    var sunset: Date = Date()
    
    let transformCelcius = TransformOf<Int, Double>(fromJSON: { (value: Double?) -> Int? in
        // transform value from Double to Int
        if let value = value {
            return Int(value)
        }
        return nil
    }, toJSON: { (value: Int?) -> Double? in
        // transform value from Int to Double
        if let value = value {
            return Double(value)
        }
        return nil
    })
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        temperature <- (map["main.temp"], transformCelcius)
        location <- map["name"]
        description <- map["weather.description"]
        sunrise <- (map["sys.sunrise"], DateTransform())
        sunset <- (map["sys.sunset"], DateTransform())
    }
}
