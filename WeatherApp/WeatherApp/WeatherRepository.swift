//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Alejos on 3/20/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation
import Alamofire

struct WeatherRepository {
    static let appId = "3f3a608541a999f9d309a7f2b3f36ac7"
    
    static func getWeather (location: Geolocation, onClosure: @escaping (_ weather: Dictionary <String, Any>?, _ error: Error?) -> Void) {
        Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(appId)").responseJSON(completionHandler: { (response) in
            if let responseError = response.error {
                onClosure(nil, responseError)
            }
            if let JSON = response.result.value as? Dictionary <String, Any>{
                onClosure(JSON, nil)
            }
        })
    }
}
