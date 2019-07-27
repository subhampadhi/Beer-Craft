//
//  HomeView.swift
//  Beer Craft
//
//  Created by Subham Padhi on 27/07/19.
//  Copyright © 2019 Subham Padhi. All rights reserved.
//

import Foundation
import UIKit

class HomeView: UIViewController {
    
    var mainTable: UITableView = {
       let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .none
        return view
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    func initViews() {
        
        navigationItem.title = "B E E R C R A F T"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.init(red: 232/255, green: 157/255, blue: 57/255, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
       
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let button = UIButton.init(type: .custom)
        button.setImage(#imageLiteral(resourceName: "cart_empty"), for: .normal)
        button.addTarget(self, action:#selector(HomeVC.addTapped), for:.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        view.addSubview(mainTable)
        
        mainTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        searchController.searchBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        mainTable.tableHeaderView = searchController.searchBar
    }
}
