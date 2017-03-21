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
    case getForecast(geolocation: Geolocation, units: TemperatureUnits)
    
    static let appId = "3f3a608541a999f9d309a7f2b3f36ac7"
    static let forecastDays = 5
    
    enum TemperatureUnit : String {
        case celsius = "metric"
        case farenheit = "imperial"
        case kelvin = ""
    }
    
    var method: HTTPMethod {
        switch self {
        case .getWeather, .getForecast:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getWeather:
            return "/weather"
        case .getForecast:
            return "/forecast/daily"
        }
        
    }
    
    var parameters: Parameters {
        let parameters: (_ geo: Geolocation, _ unit: TemperatureUnit) -> (Parameters) = { (geo, unit) in
            var params = ["appid": WeatherRouter.appId,
                          "lat":   geo.latitude,
                          "lon":   geo.longitude]
            if unit != .kelvin {
                params["units"] = unit.rawValue
            }
            
            return params
        }
        switch self {
        case let .getWeather(geolocation, unit):
            return parameters(geolocation, unit)
            
        case let .getForecast(geolocation, unit):
            var parameters = parameters(geolocation, unit)
            parameters["cnt"] = WeatherRouter.forecastDays
            
            return parameters
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = APIManager.baseURL
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getWeather, .getForecast:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}

