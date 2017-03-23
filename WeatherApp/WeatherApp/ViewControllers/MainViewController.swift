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
    var currentGeolocation = Geolocation()
    var currentWeather = Weather()
    var forecastArray = [Forecast]()
    let forecastSegueIdentifier = "forecastSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.getLocation { (geolocation, error) in
            if geolocation != nil {
                self.checkWeather(geolocation: geolocation!)
            } else {
                print(error ?? "error getting location")
            }
        }
    }
    
    @IBAction func forecastTapped(_ sender: Any) {
        self.performSegue(withIdentifier: self.forecastSegueIdentifier, sender: self)
    }
    
    func checkWeather (geolocation: Geolocation) {
        currentGeolocation = geolocation
        WeatherService.getWeather(geolocation: geolocation, onComplete: { (weather, error) in
            if let weather = weather {
                self.configureView(with: weather)
            } else {
                print(error ?? "error on weather request")
            }
        })
    }
    
    func configureView (with weather: Weather) {
        weatherLabel.text = weather.description
        locationLabel.text = weather.location
        temperatureLabel.text = "\(weather.temperature)C"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let sunriseDate = dateFormatter.string(from: weather.sunrise)
        let sunsetDate = dateFormatter.string(from: weather.sunset)
        sunriseLabel.text = sunriseDate
        sunsetLabel.text = sunsetDate
        currentWeather = weather
    }
}

extension MainViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == forecastSegueIdentifier {
            let forecastViewController = segue.destination as! ForecastViewController
            
            forecastViewController.currentWeather = currentWeather
            forecastViewController.configureView(with: currentGeolocation)
        }
    }
}
