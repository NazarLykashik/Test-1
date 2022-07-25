//
//  MapViewController.swift
//  Test 1
//
//  Created by Nazar Lykashik on 25.07.22.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        chechLocationEnable()
        chechAutorization()
    }
    func chechLocationEnable(){
        if CLLocationManager.locationServicesEnabled(){
            setupManager()
        }else{
            showAlertLocation(title: "У вас не включена служба геолокации", message: "Включить?", url: URL(string: "App-Prefs:root=LOCATION_SERVICES"))
            
        }
    }
    func setupManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    func chechAutorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
            break
        case .denied:
            showAlertLocation(title: "Вы запретили использовать геолокацию", message: "Исправить?", url: URL(string: UIApplication.openSettingsURLString))
            break
        case .restricted:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()

        }
    }
    func showAlertLocation(title: String, message: String?, url:URL?){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alert) in
        if let url = url{
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    let okAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
    alert.addAction(settingsAction)
    alert.addAction(okAction)
    
    present(alert, animated: true, completion: nil)
    }


}
extension MapViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate{
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(region, animated: true)
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        chechAutorization()
    }
    
}

