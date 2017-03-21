//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Alejos on 3/20/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    let locationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let geolocation = locationManager.getLocation(sender: self) {
            checkWeather(geolocation: geolocation)
        }
    }
    
    @IBAction func forecastTapped(_ sender: Any) {
//        WeatherService.getForecast(geolocation: <#T##Geolocation#>, onClosure: <#T##(Weather?, Error?) -> Void#>)
    }
    
    func checkWeather (geolocation: Geolocation) {
        WeatherService.getWeather(geolocation: geolocation, onClosure: { (weather, error) in
            if (error == nil){
                if let weather = weather {
                    self.weatherLabel.text = weather.description
                    self.locationLabel.text = weather.location
                    self.temperatureLabel.text = "\(weather.temperature)C"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "h:mm a"
                    let sunriseDate = dateFormatter.string(from: weather.sunrise)
                    let sunsetDate = dateFormatter.string(from: weather.sunset)
                    self.sunriseLabel.text = sunriseDate
                    self.sunsetLabel.text = sunsetDate
                }
            } else{
                print(error ?? "error on service request")
            }
        })
    }
}

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        if let coordinates = location?.coordinate {
            let geolocation = Geolocation(lat: String(format:"%f",coordinates.latitude), lng: String(format:"%f",coordinates.longitude))
            checkWeather(geolocation: geolocation)
        } else {
            checkWeather(geolocation: Geolocation())
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        checkWeather(geolocation: Geolocation())
    }
    
}
