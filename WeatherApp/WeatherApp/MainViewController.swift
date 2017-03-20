//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Alejos on 3/20/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var celciusLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkWeather()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkWeather () {
        let location = Geolocation.init()
        WeatherService.getWeather(location: location, onClosure: { (weather, error) in
            if (error == nil){
                if let weather = weather {
                    self.weatherLabel.text = weather.description
                    self.locationLabel.text = weather.location
                    self.celciusLabel.text = "\(weather.celcius)"
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "h:mm a"
                    let sunriseDate = dateFormatter.string(from: weather.sunrise)
                    let sunsetDate = dateFormatter.string(from: weather.sunset)
                    self.sunriseLabel.text = sunriseDate
                    self.sunsetLabel.text = sunsetDate
                }
            } else{
                print(error)
            }
        })
    }

}
