//
//  HeaderTableViewCell.swift
//  Weathered
//
//  Created by Michael Amiro on 05/11/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class HeaderTableView: UITableViewHeaderFooterView {
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var chanceOfRainLabel: UILabel!
    @IBOutlet weak var windInfoLabel: UILabel!
}
