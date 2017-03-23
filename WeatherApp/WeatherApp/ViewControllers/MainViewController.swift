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

    //MARK: UI elements
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    //MARK: Local variables and constants
    var forecastArray = [Forecast]()
    let forecastSegueIdentifier = "forecastSegue"
    
    //MARK: Initial configuration
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.sharedInstance.getLocation { (geolocation, error) in
            if geolocation != nil {
                self.checkWeather(geolocation: geolocation!)
            } else {
                print(error ?? "error getting location from device")
            }
        }
    }
    
    //MARK: UI actions
    @IBAction func forecastTapped(_ sender: Any) {
        self.performSegue(withIdentifier: self.forecastSegueIdentifier, sender: self)
    }
    
    //MARK: Local functions
    func checkWeather (geolocation: Geolocation) {
        WeatherService.sharedInstance.getWeather(geolocation: geolocation, onComplete: { (weather, error) in
            if let weather = weather {
                self.configureView(with: weather)
            } else {
                print(error ?? "error on weather request")
            }
        })
    }
    
    //MARK: UI configuration
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
    }
}

//MARK: Segue implementation
extension MainViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == forecastSegueIdentifier {
            let forecastViewController = segue.destination as! ForecastViewController
            
            forecastViewController.configureView()
        }
    }
}
