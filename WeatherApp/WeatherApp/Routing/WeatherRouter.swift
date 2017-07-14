//
//  WeatherRouter.swift
//  WeatherApp
//
//  Created by Alejos on 3/21/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Alamofire

enum WeatherRouter: URLRequestConvertible {
    
    //MARK: Request cases
    case getWeather(geolocation: Geolocation, unit: TemperatureUnit)
    case getForecast(geolocation: Geolocation, unit: TemperatureUnit)
    
    //MARK: Constants
    static let forecastDays = 6
    
    enum TemperatureUnit : String {
        case celsius = "metric"
        case farenheit = "imperial"
        case kelvin = ""
    }
    
    //MARK: Variables
    var url: URL {
        switch self {
        case .getWeather, .getForecast:
            return APIManager.baseURL
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
    
    var method: HTTPMethod {
        switch self {
        case .getWeather, .getForecast:
            return .get
        }
    }
    
    var parameters: Parameters {
        let parameters: (_ geo: Geolocation, _ unit: TemperatureUnit) -> (Parameters) = { (geo, unit) in
            var params = ["appid": APIManager.appId,
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
        default:
            return Parameters()
        }
    }
    
    //MARK: Request functions
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .getWeather, .getForecast:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}

