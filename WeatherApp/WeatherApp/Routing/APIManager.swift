//
//  APIManager.swift
//  WeatherApp
//
//  Created by Alejos on 3/21/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import Foundation

struct APIManager {
    //MARK: Environmental variables
    static var serverURL: String {
        return "http://api.openweathermap.org/data/2.5"
    }
    
    static var imageURL: String {
        return "http://openweathermap.org"
    }
    
    static var appId: String {
        return "3f3a608541a999f9d309a7f2b3f36ac7"
    }
    
    //MARK: Constructed URL constants
    static let baseURL: URL = URL(string: serverURL)!
    static let iconURL: URL = URL(string: imageURL)!
}
