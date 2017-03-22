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
    
    let forecastCellIdentifier = "forecastCell"
    let dayOfTheWeek = ["0":"MON", "1":"TUE", "2":"WED", "3":"THU", "4":"FRI", "5":"SAT", "6":"SUN"]
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
    
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: forecastCellIdentifier, for: indexPath) as! ForecastTableViewCell
        let forecast = forecastArray[indexPath.row]
        cell.forecast = forecast
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "F"
        let dayNumber = dateFormatter.string(from: forecast.date)
        cell.dateLabel.text = dayOfTheWeek[dayNumber]
        
        if let pictureURL = URL.init(string: "http://openweathermap.org/img/w/\(forecast.icon).png"){
            if let data = try? Data(contentsOf: pictureURL) {
                cell.iconImageView.image = UIImage(data: data)
            }
        }
        cell.descriptionLabel.text = forecast.description
        cell.maxTemperature.text = "\(forecast.maxTemperature)C"
        cell.minTemperature.text = "\(forecast.minTemperature)C"
        return cell
    }
}
