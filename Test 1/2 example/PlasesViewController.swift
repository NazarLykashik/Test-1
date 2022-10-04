//
//  PlasesViewController.swift
//  Test 1
//
//  Created by Nazar Lykashik on 18.08.22.
//

import UIKit
import Alamofire

class PlasesViewController: UITableViewController {
    
    @IBOutlet var DetailTableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    
    let jsonOfPlases = "https://krokapp.by/api/get_points/11/"
    var placesRu: [Plases] = []
    var currentPlace: [Plases] = []
    var cityId = 0
    var cityName = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPlases()
        tableView.rowHeight = 100
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        placesRu = StorageManager.shared.getPlace()
        currentPlace = placesRu.filter{$0.city_id == cityId}
        navigationItem.title = cityName
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentPlace.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOfPlaces", for: indexPath) as! ModifidedCell
        let place = currentPlace[indexPath.row]
        cell.configurePlace(with: place)
        activityIndicator.stopAnimating()
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let plasesVC = segue.destination as! PlaceViewController
            let place = currentPlace[indexPath.row]
            plasesVC.name = place.name ?? "no data -> error"
            plasesVC.text = place.text ?? "no data -> error"
            plasesVC.sound = place.sound ?? "no data -> error"
            plasesVC.creation_date = place.creation_date ?? "no data -> error"
            plasesVC.photo = place.photo ?? "no data -> error"
        }
    }
    
    func fetchPlases(){
        guard let url = URL(string: jsonOfPlases) else {return}
        AF.request(url).validate().responseJSON { dataResponse in
            switch dataResponse.result{
            case .success(let value):
                self.placesRu = Plases.getPlases(from: value).filter { $0.lang == 3 && $0.name != ""}
                //&& $0.city_id == self.cityId }
                StorageManager.shared.savePlases(self.placesRu)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
