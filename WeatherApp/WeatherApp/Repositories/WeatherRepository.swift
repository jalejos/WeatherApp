//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Alejos on 3/20/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

struct WeatherRepository {
    
    static func getWeather (geolocation: Geolocation, onClosure: @escaping (_ weather: Dictionary <String, Any>?, _ error: Error?) -> Void) {
        Alamofire.request(WeatherRouter.getWeather(geolocation: geolocation, unit: .celsius)).responseJSON(completionHandler: { (response) in
            if let responseError = response.error {
                onClosure(nil, responseError)
            }
            if let JSON = response.result.value as? Dictionary <String, Any>{
                onClosure(JSON, nil)
            }
        })
    }
    
    static func getForecast (geolocation: Geolocation, onClosure: @escaping (_ forecast: Dictionary <String, Any>?, _ error: Error?) -> Void) {
        Alamofire.request(WeatherRouter.getForecast(geolocation: geolocation, unit: .celsius)).responseJSON { (response) in
            if let responseError = response.error {
                onClosure(nil, responseError)
            }
            if let JSON = response.result.value as? Dictionary <String, Any> {
                onClosure(JSON, nil)
            }
        }
    }
    
    static func getIcon (identifier: String, onComplete: @escaping (_ icon: UIImage?, _ error: Error?) -> Void) {
        let imageCache = AutoPurgingImageCache()
        if let cachedIcon = imageCache.image(withIdentifier: identifier) {
            onComplete(cachedIcon, nil)
        } else {
            Alamofire.request(WeatherRouter.getIcon(identifier: identifier)).responseImage { (response) in
                if let image = response.result.value {
                    imageCache.add(image, withIdentifier: identifier)
                    onComplete(image, nil)
                } else if let error = response.error {
                    onComplete(nil, error)
                } else {
                    let error = NSError.init(domain: "", code: 204, userInfo: nil)
                    onComplete(nil, error)
                }
            }
        }
    }
}
