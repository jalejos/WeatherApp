//
//  Forecast.swift
//  WeatherApp
//
//  Created by Alejos on 3/21/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import ObjectMapper

class Forecast: Mappable {
    var maxTemperature: Int = 0
    var minTemperature: Int = 0
    var description: String = ""
    var date: Date = Date()
    var icon: String = ""
    
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
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        maxTemperature <- (map["temp.max"], transformTemperature)
        minTemperature <- (map["temp.min"], transformTemperature)
        description <- map["weather.0.main"]
        date <- (map["dt"], DateTransform())
        icon <- (map["weather.0.icon"])
    }
}
