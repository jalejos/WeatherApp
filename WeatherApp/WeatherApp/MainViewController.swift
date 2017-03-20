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
        
    }

}
