//
//  CityViewController.swift
//  Test 1
//
//  Created by Nazar Lykashik on 26.07.22.
//

import UIKit

class CityViewController: UIViewController, UITableViewDataSource {


    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "City"
        
        return cell
    }
    

}
