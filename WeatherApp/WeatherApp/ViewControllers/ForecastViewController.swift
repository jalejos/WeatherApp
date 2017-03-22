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
        return UITableViewCell()
    }
}
