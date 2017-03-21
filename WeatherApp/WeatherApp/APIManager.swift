//
//  APIManager.swift
//  WeatherApp
//
//  Created by Alejos on 3/21/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation

struct APIManager {
    static var serverURL: String {
        return "http://api.openweathermap.org/data/2.5"
    }
    
    static let baseURL: URL = URL(string: serverURL)!
}
