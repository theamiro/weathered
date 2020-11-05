//
//  ForecastTableViewCell.swift
//  Weathered
//
//  Created by Michael Amiro on 05/11/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var chanceOfRainLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    func configureTableCell(using forecast: [List]) {
        
    }
}
