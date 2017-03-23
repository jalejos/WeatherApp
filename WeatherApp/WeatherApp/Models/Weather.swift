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
    //MARK: Default values
    var temperature: Int = 0
    var location: String = "0"
    var description: String = ""
    var sunrise: Date = Date()
    var sunset: Date = Date()
    var maxTemperature: Int = 0
    var minTemperature: Int = 0
    
    //MARK: Custom transformation methods
    let transformTemperature = TransformOf<Int, Double>(fromJSON: { (value: Double?) -> Int? in
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
    
    //MARK: ObjectMapper methods
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        temperature <- (map["main.temp"], transformTemperature)
        location <- map["name"]
        description <- map["weather.0.main"]
        sunrise <- (map["sys.sunrise"], DateTransform())
        sunset <- (map["sys.sunset"], DateTransform())
        maxTemperature <- (map["main.temp_max"], transformTemperature)
        minTemperature <- (map["main.temp_min"], transformTemperature)
    }
}
