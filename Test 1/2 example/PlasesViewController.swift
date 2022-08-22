//
//  PlasesViewController.swift
//  Test 1
//
//  Created by Nazar Lykashik on 18.08.22.
//

import UIKit

class PlasesViewController: UITableViewController {
    
    @IBOutlet var DetailTableView: UITableView!
    
    let jsonOfPlases = "https://krokapp.by/api/get_points/11/"
    var places: [Plases] = []
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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func fetchPlases(){
        guard let url = URL(string: jsonOfPlases) else {return}
        URLSession.shared.dataTask(with: url) { [self] (data, _, error) in
        
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else {return}
            do {
                self.places = try JSONDecoder().decode([Plases].self, from: data)
                let lang = places.filter { $0.lang == 3 && $0.name != "" && $0.city_id == cityId }
                placesRu = lang
                print(placesRu)

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error{
                print(error)
            }
        }.resume()
    }
    
}
