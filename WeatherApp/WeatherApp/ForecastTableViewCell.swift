//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Alejos on 3/21/17.
//  Copyright © 2017 Alejos. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    @IBOutlet weak var minTemperature: UILabel!
    
    var forecast = Forecast()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
