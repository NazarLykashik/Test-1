//
//  MapController.swift
//  Test 1
//
//  Created by Nazar Lykashik on 26.07.22.
//

import UIKit

class MapController: UIViewController {
    @IBOutlet var map: GMSMapView!
    
    // 1) create class Point
    // 2) Point[] = []
    // 3) create [] GMSMarker[] title === pointname
    
    
//    let markers = [ {lang: 54, lat: 27}, {lang:56, lat: 26} ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let position = CLLocationCoordinate2D(latitude: 53, longitude: 27)
        let marker = GMSMarker(position: position)
        marker.title = "Hello World"
        marker.map = map
 }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
