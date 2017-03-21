//
//  WeatherRouter.swift
//  WeatherApp
//
//  Created by Alejos on 3/21/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Alamofire

enum WeatherRouter: URLRequestConvertible {
    case getWeather(geolocation: Geolocation, units: TemperatureUnits)
    
    static let appId = "3f3a608541a999f9d309a7f2b3f36ac7"
    
    enum TemperatureUnits : String {
        case celsius = "metric"
        case farenheit = "imperial"
        case kelvin = ""
    }
    
    var method: HTTPMethod {
        switch self {
        case .getWeather:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getWeather:
            return "/weather"
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .getWeather(geolocation, units):
            var parameters = ["appid": WeatherRouter.appId,
                              "lat":   geolocation.latitude,
                              "lon":   geolocation.longitude]
            
            if units != .kelvin {
                parameters["units"] = units.rawValue
            }
            
            return parameters
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = APIManager.baseURL
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getWeather:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}

