//
//  ViewController.swift
//  Weathered
//
//  Created by Michael Amiro on 04/11/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class BookmarkedLocationsCell: UICollectionViewCell {
    static let reuseIdentifier = "locationCell"
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
}

class ViewController: UIViewController {
    var bookmarkedLocations = [Favourite]()
    var selectedCity: Favourite?
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext!
    
    var previousLocation: CLLocation?
    var city: String?
    
    var addLocationButton: UIButton = {
        var button = UIButton()
        button.setTitle("Favourite", for: .normal)
        button.backgroundColor = UIColor.gray
        button.layer.cornerRadius = 18.0
        return button
    }()
    
    let locationManager = CLLocationManager()
    var list = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addLocationButton)
        addLocationButton.translatesAutoresizingMaskIntoConstraints = false
        addLocationButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 156.0).isActive = true
        addLocationButton.heightAnchor.constraint(equalToConstant: 36.0).isActive = true
        addLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        addLocationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        
        addLocationButton.addTarget(self, action: #selector(addFavouriteLocation), for: .touchUpInside)
        
        let fetchRequest: NSFetchRequest<Favourite> = Favourite.fetchRequest()
        
        do {
            if #available(iOS 10.0, *) {
                let locations = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
                self.bookmarkedLocations = locations
                self.collectionView.reloadData()
            } else {
            }
        } catch {
            
        }
        getSetLocationServices()
    }
    
    private func getSetLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            checkLocationAuthStatus()
        } else {
            self.present(AlertsController().generateAlert(withError: "Error getSetting Location Services"), animated: true)
        }
    }
    func centerUserLocationOnView() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(region, animated: true)
        }
    }
    private func checkLocationAuthStatus() {
        switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
                centerUserLocationOnView()
                previousLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                break
            case .restricted:
                self.present(AlertsController().generateAlert(withError: "Seems you are not permitted to change the Location Setting. Contact the device administrator."), animated: true)
                break
            case .denied:
                self.present(AlertsController().generateAlert(withError: "Our request to access Location Services has been denied."), animated: true)
                break
            case .authorizedAlways:
                mapView.showsUserLocation = true
                centerUserLocationOnView()
                break
            @unknown default:
                break
        }
    }
    @objc
    private func addFavouriteLocation() {
        if #available(iOS 10.0, *) {
            context = appDelegate.persistentContainer.viewContext
            let favourite = Favourite(context: context)
            
            let latitude = mapView.centerCoordinate.latitude
            let longitude = mapView.centerCoordinate.longitude
            
            favourite.latitude = latitude
            favourite.longitude = longitude
            favourite.name = self.city
            appDelegate.saveContext()
            self.bookmarkedLocations.append(favourite)
            self.collectionView.reloadData()
        } else {
            print("Low version")
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookmarkedLocations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookmarkedLocationsCell.reuseIdentifier, for: indexPath) as? BookmarkedLocationsCell else {
            return UICollectionViewCell()
        }
        cell.locationNameLabel.text = bookmarkedLocations[indexPath.row].name
        cell.latitudeLabel.text = String(format: "%.4f", bookmarkedLocations[indexPath.row].latitude)
        cell.longitudeLabel.text = String(format: "%.4f",bookmarkedLocations[indexPath.row].longitude)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let city = bookmarkedLocations[indexPath.row]
        
        APIRequest().makeCall(latitude: city.latitude, longitude: city.longitude) { [weak self] response in
            print(response)
        }
        selectedCity = city
        
        self.performSegue(withIdentifier: "toCity", sender: self)
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
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        let coder = CLGeocoder()
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        coder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let _ = error {
                self.present(AlertsController().generateAlert(withError: "Error: \(error ?? "Error getting address" as! Error)"), animated: true)
                return
            }
            guard let placemark = placemarks?.first else {
                return
            }
            if let locality = placemark.locality {
                self.city = placemark.name
            } else {
                self.city = placemark.locality
            }
            
        }
        print(center)
    }
}
