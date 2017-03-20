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
    var celcius: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        celcius <- map["celcius"]
    }
}
