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
    static func getWeather (location: Geolocation, onClosure: @escaping (_ weather: Dictionary <String, AnyObject>?, _ error: Error?) -> Void) {
        Alamofire.request("api.openweathermap.org/data/2.5/weather?lat=\(location.latitude)&lon=\(location.longitude)").responseJSON(completionHandler: { (response) in
            if let responseError = response.error {
                onClosure(nil, responseError)
            }
            if let JSON = response.result.value as? Dictionary <String, AnyObject>{
                onClosure(JSON, nil)
            }
        })
    }
}
