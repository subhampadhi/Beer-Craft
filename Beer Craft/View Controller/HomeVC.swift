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
