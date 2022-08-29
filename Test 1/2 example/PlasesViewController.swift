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
    
    let jsonOfPlases = "https://krokapp.by/api/get_points/11/"
    var placesRu: [Plases] = []
    var cityId = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPlases()
        print("айдишка\(cityId)")
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return placesRu.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOfPlaces", for: indexPath)
        let place = placesRu[indexPath.row]
        cell.textLabel?.text = place.name

        // MARK: - modod without multithreading
        //        let imageUrl = URL(string: city.logo)!
        //        let imageData = try? Data(contentsOf: imageUrl)

        //        cell.imageView?.image = UIImage(data: imageData!)
                
        // MARK: - modod with multithreading

                        DispatchQueue.global().async {
                            guard let imageUrl = URL(string: place.logo!) else {return}
                            guard let imageData = try? Data(contentsOf: imageUrl) else {return}
                
                            DispatchQueue.main.async {
                                cell.imageView?.image = UIImage(data: imageData)
                            }
                        }
        

        return cell
    }

    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let plasesVC = segue.destination as! PlaceViewController
            let place = placesRu[indexPath.row]
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
                self.placesRu = Plases.getPlases(from: value).filter { $0.lang == 3 && $0.name != "" && $0.city_id == self.cityId }
                //print(self.placesRu)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
