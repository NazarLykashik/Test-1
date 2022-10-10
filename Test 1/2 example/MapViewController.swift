//
//  MapViewController.swift
//  Test 1
//
//  Created by Nazar Lykashik on 2.09.22.
//

import UIKit
import Alamofire

class MapViewController: UIViewController {
    @IBOutlet var mapView: GMSMapView!
    
    let jsonOfPlases = "https://krokapp.by/api/get_points/11/"
    var placesRu: [Plases] = []
    var cityId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPlases()
    }
    // MARK: - Networking

    func fetchPlases(){
        guard let url = URL(string: jsonOfPlases) else {return}
        AF.request(url).validate().responseJSON { dataResponse in
            switch dataResponse.result{
            case .success(let value):
                self.placesRu = Plases.getPlases(from: value).filter { $0.lang == 3 && $0.name != "" && $0.lng != 30 }
                for plase in self.placesRu {
                    let position = CLLocationCoordinate2D(latitude: CLLocationDegrees (Float(plase.lat)), longitude: CLLocationDegrees (Float(plase.lng)))
                    let marker = GMSMarker(position: position)
                    marker.title = plase.name
                    marker.map = self.mapView
                }
            case .failure(let error):
                print(error)
            }
    }
        
    
}
}

