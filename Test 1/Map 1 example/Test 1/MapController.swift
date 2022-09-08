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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPoints()
 
 }
    func fetchPoints(){
        guard let url = URL(string: pointsUrl) else {return}
        AF.request(url).validate().responseJSON { dataResponse in
            switch dataResponse.result{
            case .success(let value):
                self.points = Points.getPoinst(from: value).filter { $0.lang_id == 3 && $0.point_name != "" }
                for point in self.points {
                    
                    let position = CLLocationCoordinate2D(latitude: CLLocationDegrees(Float(point.point!.lat)), longitude: CLLocationDegrees(Float(point.point!.lng)))
                    let marker = GMSMarker(position: position)
                    marker.title = point.point_name?.html2String
                    marker.map = self.map
                    
                    //print(point)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}


