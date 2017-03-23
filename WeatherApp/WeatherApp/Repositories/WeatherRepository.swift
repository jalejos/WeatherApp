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
    
    
    //MARK: Custom error
    static let noContentError = NSError.init(domain: "", code: 204, userInfo: nil)
    
    //MARK: Get requests
    static func getWeather (geolocation: Geolocation, onComplete: @escaping (_ weather: Dictionary <String, Any>?, _ error: Error?) -> Void) {
        Alamofire.request(WeatherRouter.getWeather(geolocation: geolocation, unit: .celsius)).responseJSON(completionHandler: { (response) in
            if let JSON = response.result.value as? Dictionary <String, Any>{
                onComplete(JSON, nil)
            } else if let responseError = response.error {
                onComplete(nil, responseError)
            } else {
                onComplete(nil, noContentError)
            }
        })
    }
    
    static func getForecast (geolocation: Geolocation, onComplete: @escaping (_ forecast: Dictionary <String, Any>?, _ error: Error?) -> Void) {
        Alamofire.request(WeatherRouter.getForecast(geolocation: geolocation, unit: .celsius)).responseJSON { (response) in
            if let JSON = response.result.value as? Dictionary <String, Any> {
                onComplete(JSON, nil)
            } else if let responseError = response.error {
                onComplete(nil, responseError)
            } else {
                onComplete(nil, noContentError)
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
                    onComplete(nil, noContentError)
                }
            }
        }
    }
}
