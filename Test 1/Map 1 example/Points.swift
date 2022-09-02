//
//  Point.swift
//  Test 1
//
//  Created by Nazar Lykashik on 27.07.22.
//

import Foundation

struct Points: Decodable{
    let id : Int?
    let lang_id : Int?
    let visible : Bool?
    let point_name : String?
    let point: BodyOfPoint?
    
    init (dictPoint: [String: Any]){
        id = dictPoint["id"] as? Int
        lang_id = dictPoint["lang_id"] as? Int
        visible = dictPoint["visible"] as? Bool
        point_name = dictPoint["point_name"] as? String
        point = BodyOfPoint.getBody(from: dictPoint["point"] as Any)
    }
    static func getPoinst(from jsonData: Any) -> [Points]{
        guard let jsonData = jsonData as? Array <[String: Any]> else {return []}
        return jsonData.compactMap{ Points(dictPoint: $0) }
    }
}

struct BodyOfPoint: Decodable{
    let id : Int?
    let point_district_id : Int?
    let water_object_id : Int?
    let point_geo_type : String?
    let lat : Double
    let lng : Double
    let lat_2 : Double?
    let lng_2 : Double?
    
    init (dictBody: [String: Any]){
        id = dictBody["id"] as? Int
        point_district_id = dictBody["point_district_id"] as? Int
        water_object_id = dictBody["water_object_id"] as? Int
        point_geo_type = dictBody["point_geo_type"] as? String
        lat = dictBody["lat"] as? Double ?? 50
        lng = dictBody["lng"] as? Double ?? 30
        lat_2 = dictBody["lat_2"] as? Double
        lng_2 = dictBody["lng_2"] as? Double
    }
    static func getBody(from jsonData: Any) -> BodyOfPoint?{
        guard let jsonData = jsonData as? [String: Any] else {return nil}
        return BodyOfPoint(dictBody: jsonData)
    }
}


