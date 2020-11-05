//
//  WeatherHeaderView.swift
//  Weathered
//
//  Created by Michael Amiro on 05/11/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class WeatherHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var chanceOfRainLabel: UILabel!
    @IBOutlet weak var windInfoLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    func configureHeaderView(using forecast: List) {
        weatherLabel.text = forecast.weather.first?.main.rawValue
        
        let temperature = forecast.main.temp
        temperatureLabel.text = String(format: "%.0f", temperature) + "°"
        
        let chanceOfRain = forecast.rain!.the3H
        let probability = String(format: "%.0f", chanceOfRain * 100)
        chanceOfRainLabel.text = probability + "%"
        
        let windSpeed = forecast.wind.speed
        let windDirection = forecast.wind.deg
        
        let windInfo = String(format: "%.0f", windDirection) + "° " + String(format: "%.0f", windSpeed) + " kph"
        windInfoLabel.text = windInfo
        
        let humidity = forecast.main.humidity
            humidityLabel.text = String(humidity) + "%"
    }
    private func configureWeatherLabel() {
        
    }
}
