//
//  MapController.swift
//  Test 1
//
//  Created by Nazar Lykashik on 26.07.22.
//

import UIKit
import Alamofire

class MapController: UIViewController {
    @IBOutlet var map: GMSMapView!
    
    let pointsUrl = "https://fish-pits.krokam.by/api/rest/points/?format=json"
    var points: [Points] = []
    
    
    // 1) create class Point
    // 2) Point[] = []
    // 3) create [] GMSMarker[] title === pointname
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPoints()
 
 }
    func fetchPoints(){
        guard let url = URL(string: pointsUrl) else {return}
        AF.request(url).validate().responseJSON { dataResponse in
            switch dataResponse.result{
            case .success(let value):
                //print(value)
                self.points = Points.getPoinst(from: value)//.filter { $0.lang_id == 3 && $0.point_name != "" }
                self.viewDidLoad()
                print(self.points)
                for point in self.points {
                    
                    let position = CLLocationCoordinate2D(latitude: CLLocationDegrees(Float(point.point!.lat)), longitude: CLLocationDegrees(Float(point.point!.lng)))
                    let marker = GMSMarker(position: position)
                    marker.title = point.point_name
                    marker.map = self.map
                    
                    //print(point)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
//    // MARK: - CLLocationManagerDelegate
//    //1
//    extension MapViewController: CLLocationManagerDelegate {
//      // 2
//      func locationManager(
//        _ manager: CLLocationManager,
//        didChangeAuthorization status: CLAuthorizationStatus
//      ) {
//        // 3
//        guard status == .authorizedWhenInUse else {
//          return
//        }
//        // 4
//        locationManager.requestLocation()
//
//        //5
//        mapView.isMyLocationEnabled = true
//        mapView.settings.myLocationButton = true
//      }
//
//      // 6
//      func locationManager(
//        _ manager: CLLocationManager,
//        didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else {
//          return
//        }
//
//        // 7
//        mapView.camera = GMSCameraPosition(
//          target: location.coordinate,
//          zoom: 15,
//          bearing: 0,
//          viewingAngle: 0)
//      }
//
//      // 8
//      func locationManager(
//        _ manager: CLLocationManager,
//        didFailWithError error: Error
//      ) {
//        print(error)
//      }
//    }


