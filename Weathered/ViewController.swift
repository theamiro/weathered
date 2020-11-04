//
//  ViewController.swift
//  Weathered
//
//  Created by Michael Amiro on 04/11/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class BookmarkedLocationsCell: UICollectionViewCell {
    static let reuseIdentifier = "locationCell"
    
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
}

class ViewController: UIViewController {
    var bookmarkedLocations = [City]()
    @IBOutlet weak var mapView: MKMapView!
    
    var list = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookmarkedLocationsCell.reuseIdentifier, for: indexPath) as? BookmarkedLocationsCell else {
            return UICollectionViewCell()
        }
        cell.locationNameLabel.text = "Nairobi"
        cell.weatherDescriptionLabel.text = "Light rain"
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 120.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
}
