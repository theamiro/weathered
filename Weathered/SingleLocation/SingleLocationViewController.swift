//
//  SingleCityViewController.swift
//  Weathered
//
//  Created by Michael Amiro on 05/11/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit

class SingleLocationViewController: UIViewController {
    var city: City?
    var forecast: [List]?
    let reuseIdentifier = "forecastCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = String(city!.name)
        let headerNib = UINib.init(nibName: "WeatherHeaderView", bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "WeatherHeaderView")
    }
    
}
extension SingleLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) else {
            return UITableViewCell()
        }
        DispatchQueue.main.async {
            cell.textLabel!.text = "Forecast"
        }
        return cell
    }
    
}

extension SingleLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "WeatherHeaderView") as! WeatherHeaderView
        headerCell.configureHeaderView(using: (forecast?.first)!)
        return headerCell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 230.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

}
//°
