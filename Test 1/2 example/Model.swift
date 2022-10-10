//
//  City.swift
//  Test 1
//
//  Created by Nazar Lykashik on 26.07.22.
//


struct City: Codable {
    let city_is_regional: Bool
    let id: Int
    let id_locale: Int
    let lang: Int
    let last_edit_time: Int
    let logo: String?
    let name: String
    let region: String
    let visible: Bool  
}

struct Plases: Decodable, Encodable{
    let index: Int?
    let id: Int?
    let id_point: Int?
    let name: String?
    let text: String?
    let sound: String?
    let lang: Int?
    let last_edit_time: Int?
    let creation_date: String?
    let lat: Double
    let lng: Double
    let logo: String?
    let photo: String?
    let city_id: Int?
    let visible: Bool?
    let is_excursion: Bool?
    
    
    init(dictPlase: [String: Any]){
        index = dictPlase["index"] as? Int
        id = dictPlase["id"] as? Int
        id_point = dictPlase["id_point"] as? Int
        name = dictPlase["name"] as? String
        text = dictPlase["text"] as? String
        sound = dictPlase["sound"] as? String
        lang = dictPlase["lang"] as? Int
        last_edit_time = dictPlase["last_edit_time"] as? Int
        creation_date = dictPlase["creation_date"] as? String
        lat = dictPlase["lat"] as! Double
        lng = dictPlase["lng"] as! Double
        logo = dictPlase["logo"] as? String
        photo = dictPlase["photo"] as? String
        city_id = dictPlase["city_id"] as? Int
        visible = dictPlase["visible"] as? Bool
        is_excursion = dictPlase["is_excursion"] as? Bool
    }
    
    static func getPlases(from jsonData: Any) -> [Plases]{
        guard let jsonData = jsonData as? Array <[String: Any]> else {return []}
        return jsonData.compactMap{ Plases(dictPlase: $0) }
    }
}



