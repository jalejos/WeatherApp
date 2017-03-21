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
    
    static func getWeather (geolocation: Geolocation, onClosure: @escaping (_ weather: Dictionary <String, Any>?, _ error: Error?) -> Void) {
        Alamofire.request(WeatherRouter.getWeatherRequest(geolocation: geolocation, units: .celsius)).responseJSON(completionHandler: { (response) in
            if let responseError = response.error {
                onClosure(nil, responseError)
            }
            if let JSON = response.result.value as? Dictionary <String, Any>{
                onClosure(JSON, nil)
            }
        })
    }
}
