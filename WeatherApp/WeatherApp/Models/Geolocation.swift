//
//  Geolocation.swift
//  WeatherApp
//
//  Created by Alejos on 3/20/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation

struct Geolocation {
    //MARK: Default values
    var latitude : String = "29.0730"
    var longitude : String = "-110.9559"
    
    //MARK: Initialization methods
    init(){
    }
    
    init(lat:String, lng: String){
        latitude = lat
        longitude = lng
    }
}
