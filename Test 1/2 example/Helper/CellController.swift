//
//  CellController.swift
//  Test 1
//
//  Created by Nazar Lykashik on 6.09.22.
//

import UIKit

class ModifidedCell: UITableViewCell{
    @IBOutlet var cityImage: ImageView!
    @IBOutlet var cityName: UILabel!
    
    @IBOutlet var placeImage: ImageView!
    @IBOutlet var placeName: UILabel!
    
    func configure(with city: City){
        
        guard let url = city.logo else {
            cityImage.image = #imageLiteral(resourceName: "Image")
            return
        }
        
        cityImage.fetcImage(with: url)
        
        cityName?.text = city.name
    }
    func configurePlace(with place: Plases){
        guard let url = place.logo else{
            placeImage.image = #imageLiteral(resourceName: "Image")
            return
        }
        placeImage.fetcImage(with: url)
        placeName?.text = place.name
    }
}
