//
//  HomeVC.swift
//  Beer Craft
//
//  Created by Subham Padhi on 27/07/19.
//  Copyright © 2019 Subham Padhi. All rights reserved.
//

import Foundation
import UIKit

class HomeVC: HomeView {
    
    let viewModel: HomeViewModel
    
    override func viewDidLoad() {
        mainTable.dataSource = self
        mainTable.delegate = self
        searchController.searchResultsUpdater = self
        initViews()
        self.viewModel.tableCellTypes.forEach({ $0.registerCell(tableView: self.mainTable)})
        defineClosures()
        viewModel.callApi()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel:HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    @objc func addTapped() {
        
    }
}

extension HomeVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(searchText: self.searchController.searchBar.text!)
    }
    
    func filterContent(searchText:String){
        
        self.viewModel.filteredBeerList = (self.viewModel.beerInfoList ?? [BeerInfo]()).filter({ (beerInfo) -> Bool in
                let beerName = beerInfo.name
                return (beerName?.lowercased().contains(searchText.lowercased()))!
            })
        print(self.viewModel.filteredBeerList.count)
        self.viewModel.reloadTable?()
    }
}

extension HomeVC {
    
    func defineClosures() {
        
        viewModel.reloadTable = {  [weak self] in
            guard let strongSelf = self else {return}
            if strongSelf.searchController.isActive && strongSelf.searchController.searchBar.text != "" {
                strongSelf.viewModel.assignFilteredTableCells()
                strongSelf.mainTable.reloadData()
            }else {
                strongSelf.viewModel.assignTableViewCells()
                strongSelf.mainTable.reloadData()
            }
        }
        
        viewModel.reloadSingleCell = { [weak self] index in
            guard let strongSelf = self else {return}
            let indexPath = IndexPath(item: index, section: 0)
            strongSelf.mainTable.reloadRows(at: [indexPath], with: .none)
        }
        
        viewModel.reloadfilteredData = { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.viewModel.assignLagerFilteredTableCells()
            strongSelf.mainTable.reloadData()
        }
    }
    
    @objc func sortByButtonTapped() {
        let actionSheet = UIAlertController(title: "Sort By", message: "Select the way you want to sort by", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Alcohol Content: Low - High", style: .default, handler: { (action: UIAlertAction) in
           self.viewModel.sortByAlcoholContel(isLowToHigh: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Alcohol Content: High - High", style: .default, handler: { (action: UIAlertAction) in
            self.viewModel.sortByAlcoholContel(isLowToHigh: false)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func filterByButtonTapped() {
        let actionSheet = UIAlertController(title: "Filter By", message: "Select the lager you want to search for", preferredStyle: .actionSheet)
        for lagers in self.viewModel.uniqueLagerStrings {
            actionSheet.addAction(UIAlertAction(title: "\(lagers)", style: .default, handler: { (action: UIAlertAction) in
                guard let title = action.title else {return}
                self.viewModel.filterByUniqueLager(lager: title)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Remove Filter", style: .destructive, handler: { (action: UIAlertAction) in
            self.viewModel.reloadTable?()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
}

extension HomeVC: UITableViewDelegate {
    
}

extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return viewModel.filteredtableCells.count
        } else {
            return viewModel.tableCells.count
        }}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchController.isActive && searchController.searchBar.text != "" {
            let cellViewModel = self.viewModel.filteredtableCells[indexPath.row]
            return cellViewModel.cellInstantiate(tableView: tableView,indexPath: indexPath)
        } else {
            let cellViewModel = self.viewModel.tableCells[indexPath.row]
            return cellViewModel.cellInstantiate(tableView: tableView,indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
