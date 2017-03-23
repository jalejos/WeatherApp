//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Alejos on 3/20/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    
    static let sharedInstance = LocationManager()
    
    let manager = CLLocationManager()
    var currentLocation: Geolocation? = nil
    var onComplete: (Geolocation?, Error?) -> (Void) = {_ in}
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.distanceFilter = 100
    }
    
    func getLocation(onComplete: @escaping (_ geolocation: Geolocation?, _ error: Error?) -> Void) {
        if currentLocation != nil {
            onComplete(currentLocation!, nil)
        } else {
            requestLocation(onComplete: onComplete)
        }
    }
    
    func requestLocation(onComplete: @escaping (_ geolocation: Geolocation?, _ error: Error?) -> Void) {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .restricted, .denied:
            return onComplete(Geolocation(), nil)
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
        if CLLocationManager.locationServicesEnabled() {
            self.onComplete = onComplete
            manager.requestLocation()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        if let coordinates = location?.coordinate {
            let geolocation = Geolocation(lat: String(format:"%f",coordinates.latitude), lng: String(format:"%f",coordinates.longitude))
            currentLocation = geolocation
            onComplete(currentLocation, nil)
        } else {
            onComplete(nil, nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        onComplete(nil, error)
    }
}
