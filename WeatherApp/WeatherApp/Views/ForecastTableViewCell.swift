//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Alejos on 3/21/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit
import AlamofireImage

class ForecastTableViewCell: UITableViewCell {
    
    //MARK: UI elements
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    @IBOutlet weak var minTemperature: UILabel!
    
    func configureCell (forecast: Forecast) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        dateLabel.text = dateFormatter.string(from: forecast.date).uppercased()
        
        WeatherService.sharedInstance.getIcon(identifier: forecast.icon) { (icon, error) in
            self.iconImageView.image = icon
        }
        
        descriptionLabel.text = forecast.description
        maxTemperature.text = "\(forecast.maxTemperature)C"
        minTemperature.text = "\(forecast.minTemperature)C"
    }
}
