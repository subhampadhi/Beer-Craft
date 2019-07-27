//
//  AllBeerInfoModel.swift
//  Beer Craft
//
//  Created by Subham Padhi on 27/07/19.
//  Copyright © 2019 Subham Padhi. All rights reserved.
//


import Foundation

struct BeerInfo : Codable {
    
    let abv : String?
    let ibu : String?
    let id : Int?
    let name : String?
    let ounces : Double?
    let style : String?
    
    enum CodingKeys: String, CodingKey {
        case abv = "abv"
        case ibu = "ibu"
        case id = "id"
        case name = "name"
        case ounces = "ounces"
        case style = "style"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        abv = try values.decodeIfPresent(String.self, forKey: .abv)
        ibu = try values.decodeIfPresent(String.self, forKey: .ibu)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        ounces = try values.decodeIfPresent(Double.self, forKey: .ounces)
        style = try values.decodeIfPresent(String.self, forKey: .style)
    }
    
}

