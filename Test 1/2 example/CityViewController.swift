//
//  CityViewController.swift
//  Test 1
//
//  Created by Nazar Lykashik on 26.07.22.
//

import UIKit
import Foundation

class CityViewController: UIViewController, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    private let jsonUrl = "https://krokapp.by/api/get_cities/11/"
    
    var cities: [City] = []
    var citiesRu: [City] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fechData()
        tableView.rowHeight = 100
        citiesRu = StorageManager.shared.getCity()
        self.navigationItem.title = "Города"

    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return citiesRu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ModifidedCell
        let city = citiesRu[indexPath.row]
        cell.configure(with: city)
        return cell
    }
  // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let plasesVC = segue.destination as! PlasesViewController
            let city = citiesRu[indexPath.row]
            plasesVC.cityId = city.id
            plasesVC.cityName = city.name
            
            //print(city.id)
        }
    }



    func fechData(){
        guard let url = URL(string: jsonUrl) else {return}
        URLSession.shared.dataTask(with: url) { [self] (data, _, error) in
        
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {return}
            do {
                self.cities = try JSONDecoder().decode([City].self, from: data)
                let lang = cities.filter { $0.lang == 3 && $0.name != "" }
                citiesRu = lang
                StorageManager.shared.saveCity(citiesRu.self)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error{
                print(error)
            }
        }.resume()
    }
}


