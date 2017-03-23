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
    
    let headerSize = CGFloat(20)
    let forecastCellIdentifier = "forecastCell"
    var forecastArray = [Forecast]()
    var currentWeather = Weather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTemperatureLabel.text = "\(currentWeather.temperature)C"
        descriptionLabel.text = "\(currentWeather.description)"
        maxTemperatureLabel.text = "\(currentWeather.maxTemperature)C"
        minTemperatureLabel.text = "\(currentWeather.minTemperature)C"
        
        // Do any additional setup after loading the view.
    }
    
    func configureView(with geolocation: Geolocation) {
        WeatherService.getForecast(geolocation: geolocation, onComplete: { (forecastArray, error) in
            if error == nil {
                if let forecastArray = forecastArray {
                    self.forecastArray = forecastArray
                    self.tableView.reloadData()
                }
            } else {
                print(error ?? "error on forecast request")
            }
        })
    }
    
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerSize
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: forecastCellIdentifier, for: indexPath) as! ForecastTableViewCell
        let forecast = forecastArray[indexPath.section]
        cell.configureCell(forecast: forecast)
        return cell
    }
}
