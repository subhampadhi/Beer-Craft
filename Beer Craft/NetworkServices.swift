//
//  NetworkServices.swift
//  Beer Craft
//
//  Created by Subham Padhi on 27/07/19.
//  Copyright © 2019 Subham Padhi. All rights reserved.
//

import Foundation
import Moya

enum BeerApi {
    case getAllBeerInfo
}

extension BeerApi: TargetType {
    
    var baseURL: URL {
        return URL(string: URLConstants.BEER_BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .getAllBeerInfo:
            return "/beercraft"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllBeerInfo:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAllBeerInfo:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .getAllBeerInfo:
            return ["Content-Type":"application/json"]
        }
    }
}

