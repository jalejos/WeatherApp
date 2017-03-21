//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Alejos on 3/20/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager {
    
    let manager = CLLocationManager()
    
    func getLocation(sender: MainViewController) -> Geolocation? {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .restricted, .denied:
            return Geolocation()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = sender
            manager.desiredAccuracy = kCLLocationAccuracyKilometer
            manager.distanceFilter = 100
            manager.requestLocation()
        }
        return nil
    }
}
