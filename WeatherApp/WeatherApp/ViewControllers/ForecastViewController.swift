//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Alejos on 3/21/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    let rowSize = CGFloat(50)
    let forecastCellIdentifier = "forecastCell"
    var forecastArray = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let weather = WeatherService.sharedInstance.currentWeather {
            currentTemperatureLabel.text = "\(weather.temperature)C"
            descriptionLabel.text = "\(weather.description)"
            maxTemperatureLabel.text = "\(weather.maxTemperature)C"
            minTemperatureLabel.text = "\(weather.minTemperature)C"
        } else {
            print("error displaying current weather")
        }
        // Do any additional setup after loading the view.
    }
    
    func configureView() {
        LocationManager.sharedInstance.getLocation { (geolocation, error) in
            if geolocation != nil {
                WeatherService.sharedInstance.getForecast(geolocation: geolocation!, onComplete: { (forecastArray, error) in
                    if let forecastArray = forecastArray {
                        self.forecastArray = forecastArray
                        self.tableView.reloadData()
                    } else {
                        print(error ?? "error on forecast request")
                    }
                })
            } else {
                print(error ?? "error on getting location from device")
            }
        }
    }
    
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowSize
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: forecastCellIdentifier, for: indexPath) as! ForecastTableViewCell
        let forecast = forecastArray[indexPath.row]
        cell.configureCell(forecast: forecast)
        return cell
    }
}
