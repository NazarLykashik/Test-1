//
//  City.swift
//  Test 1
//
//  Created by Nazar Lykashik on 26.07.22.
//


struct City: Decodable {
    let city_is_regional: Bool
    let id: Int
    let id_locale: Int
    let lang: Int
    let last_edit_time: Int
    let logo: String
    let name: String
    let region: String
    let visible: Bool

    
}

struct Plases: Decodable{
    let index: Int?
    let id: Int?
    let id_point: Int?
    let name: String?
    let text: String?
    let sound: String?
    let lang: Int?
    let last_edit_time: Int?
    let creation_date: String?
    let lat: Float?
    let lng: Float?
    let logo: String?
    let photo: String?
    let city_id: Int?
    let visible: Bool?
//    let tags: Any?
    let is_excursion: Bool?
}



