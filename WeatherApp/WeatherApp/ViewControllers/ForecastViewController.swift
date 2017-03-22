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
    let dayOfTheWeek = [1:"MON", 2:"TUE", 3:"WED", 4:"THU", 5:"FRI", 6:"SAT", 7:"SUN"]
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: forecastCellIdentifier, for: indexPath) as! ForecastTableViewCell
        let forecast = forecastArray[indexPath.section]
        cell.forecast = forecast
        
        let myCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        let myComponents = myCalendar.components(.weekday, from: forecast.date)
        if let weekDay = myComponents.weekday{
            cell.dateLabel.text = dayOfTheWeek[weekDay]
        }
        
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
