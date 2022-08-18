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

    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return citiesRu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city = citiesRu[indexPath.row]
        cell.textLabel?.text = city.name
        

        
// MARK: - modod without multithreading
//        let imageUrl = URL(string: city.logo)!
//        let imageData = try? Data(contentsOf: imageUrl)

//        cell.imageView?.image = UIImage(data: imageData!)
        
// MARK: - modod with multithreading

                DispatchQueue.global().async {
                    guard let imageUrl = URL(string: city.logo) else {return}
                    guard let imageData = try? Data(contentsOf: imageUrl) else {return}
        
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: imageData)
                    }
                }

        return cell
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

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error{
                print(error)
            }
        }.resume()
    }
}


