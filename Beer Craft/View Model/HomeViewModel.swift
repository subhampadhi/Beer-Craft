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
    var uniqueLagerStrings = [String]()
    var reloadTable : (()->())?
    var reloadfilteredData: (()->())?
    var showAlert : ((String,String)->())?
    var reloadSingleCell: ((Int)->())?
    var lagerBeerInfoList: [BeerInfo]?
    
    let tableCellTypes: [CellFunctions.Type] = [PrimaryTVCHelper.self]
    private(set) var tableCells = [CellFunctions]()
    private(set) var filteredtableCells = [CellFunctions]()
}

extension HomeViewModel {
    
    func setupTableViewCells(beerInfoType: [BeerInfo]) -> [CellFunctions] {
        var cellHelpers = [CellFunctions]()
        if (beerInfoList != nil) {
            for beers in beerInfoType {
                var percent = (beers.abv?.toDouble() ?? 0.0 ) * 100
                percent = percent.rounded()
                let newCell = PrimaryTVCHelper(leadingImage: #imageLiteral(resourceName: "search_mag_glass"), topLabelText: beers.name ?? " ", bottomLabelText: beers.style ?? "", percentLabelText: "\(percent) %" )
                newCell.plusTapped = { index in
                    newCell.orderCount += 1
                    self.reloadSingleCell?(index)
                }
                newCell.miunsTapped = { index in
                    newCell.orderCount -= 1
                    self.reloadSingleCell?(index)
                }
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
            newCell.plusTapped = { index in
                newCell.orderCount += 1
                self.reloadSingleCell?(index)
            }
            newCell.miunsTapped = { index in
                newCell.orderCount -= 1
                self.reloadSingleCell?(index)
            }
            cellHelpers.append(newCell)
        }
        return cellHelpers
    }
    
    func assignTableViewCells() {
        guard let beerInfoList = self.beerInfoList else {return}
        self.tableCells = self.setupTableViewCells(beerInfoType: beerInfoList)
    }
    
    func assignFilteredTableCells() {
        self.filteredtableCells = self.setupFilteredTableViewCells()
    }
    
    func assignLagerFilteredTableCells() {
        guard let filteredList = self.lagerBeerInfoList else {return}
        self.tableCells = self.setupTableViewCells(beerInfoType: filteredList)
    }
}

extension HomeViewModel {
    
    func sortByAlcoholContel(isLowToHigh:Bool) {
        if isLowToHigh {
 
            self.beerInfoList = self.beerInfoList?.sorted(by: { (value1, value2) -> Bool in
                if let value1 = value1.abv?.toDouble() {
                    if let value2 = value2.abv?.toDouble() {
                       return value1 < value2
                    }
                }
               return false
            })
            
        } else {
            self.beerInfoList = self.beerInfoList?.sorted(by: { (value1, value2) -> Bool in
                if let value1 = value1.abv?.toDouble() {
                    if let value2 = value2.abv?.toDouble() {
                        return value1 > value2
                    }
                }
                return false
            })
        }
        self.reloadTable?()
    }
    
    func setUniquelagerValues() {
        
        for beers in beerInfoList ?? [BeerInfo]() {
            uniqueLagerStrings.append(beers.style ?? "")
        }
        uniqueLagerStrings = Array(Set(uniqueLagerStrings))
    }
    
    func filterByUniqueLager(lager:String) {
        self.lagerBeerInfoList = self.beerInfoList?.filter{ $0.style == lager}
        self.reloadfilteredData?()
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
                        self.setUniquelagerValues()
                        self.dispatchGroup.leave()
                    }
                    catch (let error) {
                        self.showAlert?("Oops", error.localizedDescription)
                        print(error.localizedDescription)
                        self.dispatchGroup.leave()
                    }
                }
            case .failure(let error):
                self.showAlert?("Oops", error.localizedDescription)
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

