//
//  HomeViewModel.swift
//  Beer Craft
//
//  Created by Subham Padhi on 27/07/19.
//  Copyright © 2019 Subham Padhi. All rights reserved.
//

import Foundation
import Moya
class HomeViewModel {
    
    private let provider = MoyaProvider<BeerApi>()
    var beerInfoList: [BeerInfo]?
    var filteredBeerList = [BeerInfo]()
    var dispatchGroup = DispatchGroup()
    var reloadTable : (()->())?
    private var paginatedBeerInfoList: [BeerInfo]?
    let tableCellTypes: [CellFunctions.Type] = [PrimaryTVCHelper.self]
    private(set) var tableCells = [CellFunctions]()
    private(set) var filteredtableCells = [CellFunctions]()
}

extension HomeViewModel {
    
    func setupTableViewCells() -> [CellFunctions] {
        var cellHelpers = [CellFunctions]()
        if (beerInfoList != nil) {
            for beers in beerInfoList! {
                var percent = (beers.abv?.toDouble() ?? 0.0 ) * 100
                percent = percent.rounded()
                let newCell = PrimaryTVCHelper(leadingImage: #imageLiteral(resourceName: "search_mag_glass"), topLabelText: beers.name ?? " ", bottomLabelText: beers.style ?? "", percentLabelText: "\(percent) %" )
                cellHelpers.append(newCell)
            }
        }
        return cellHelpers
    }
    
    func setupFilteredTableViewCells() -> [CellFunctions] {
        var cellHelpers = [CellFunctions]()
        for beers in filteredBeerList {
            var percent = (beers.abv?.toDouble() ?? 0.0 ) * 100
            percent = percent.rounded()
            let newCell = PrimaryTVCHelper(leadingImage: #imageLiteral(resourceName: "search_mag_glass"), topLabelText: beers.name ?? " ", bottomLabelText: beers.style ?? "", percentLabelText: "\(percent) %" )
            cellHelpers.append(newCell)
        }
        return cellHelpers
    }
    
    func assignTableViewCells() {
        self.tableCells = self.setupTableViewCells()
    }
    
    func assignFilteredTableCells() {
        self.filteredtableCells = self.setupFilteredTableViewCells()
    }
}

extension HomeViewModel {
    
    func callApi() {
        getAllBeerInfo()
        dispatchGroup.notify(queue: .main) {
            self.reloadTable?()
        }
    }
    
    func getAllBeerInfo() {
        
        dispatchGroup.enter()
        provider.request(.getAllBeerInfo) { (result) in
            switch result{
            case .success(let response):
                if response.statusCode == 200 {
                    do {
                        let beerInfo = try response.map([BeerInfo].self)
                        self.beerInfoList = beerInfo
                        self.dispatchGroup.leave()
                    }
                    catch (let error) {
                        print(error.localizedDescription)
                        self.dispatchGroup.leave()
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.dispatchGroup.leave()
            }
            
        }
    }
}

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}

