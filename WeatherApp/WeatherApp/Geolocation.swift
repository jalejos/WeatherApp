//
//  Geolocation.swift
//  WeatherApp
//
//  Created by Alejos on 3/20/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation

struct Geolocation {
    let latitude : String
    let longitude : String
    let defaultLat = "29.0730"
    let defaultLng = "-110.9559"
    
    init(){
        latitude = defaultLat
        longitude = defaultLng
    }
    
    init(lat:String, lng: String){
        latitude = lat
        longitude = lng
    }
}
