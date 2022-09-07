//
//  StoregeManager.swift
//  Test 1
//
//  Created by Nazar Lykashik on 5.09.22.
//

import Foundation

class StorageManager{
    static let shared = StorageManager()
    
    private var place: [Plases] = []
    private let defaults = UserDefaults.standard
    
    func getPlace() -> [Plases]{
        
        if let data = UserDefaults.standard.data(forKey: "savedPlace") {
            do {
                let decoder = JSONDecoder()
                let places = try decoder.decode([Plases].self, from: data)
                return places
            } catch {
                print("Unable to Decode places (\(error))")
            }
        }
        return place
    }
    func savePlases(_ plase: [Plases]){
        guard let plaseEncoded = try? JSONEncoder().encode(plase) else {return}
        defaults.set(plaseEncoded, forKey: "savedPlace")
    }
}
