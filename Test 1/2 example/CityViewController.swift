//
//  CityViewController.swift
//  Test 1
//
//  Created by Nazar Lykashik on 26.07.22.
//

import UIKit
import Alamofire

private let jsonUrl = "https://krokapp.by/api/get_cities/11/"
class CityViewController: UIViewController, UITableViewDataSource {
    var cities: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://krokapp.by/api/get_cities/11/").responseData {
            response in
            
            do {
                let citiesLocal = try JSONDecoder().decode([City].self, from: response.data!)
                self.cities  = citiesLocal
                       } catch let error as NSError {
                           print("Failed to load: \(error.localizedDescription)")
                       }
            print()

        }
       
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "d"
        
        return cell
    }
    

}
