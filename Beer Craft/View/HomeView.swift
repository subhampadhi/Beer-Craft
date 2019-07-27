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
    
    var sortByButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        view.setTitle("Sort", for: .normal)
        view.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.3
        view.addTarget(self, action: #selector(HomeVC.sortByButtonTapped), for: .touchUpInside)
        return view
    }()
    
    var separatorView: UIView = {
        var view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.3
        return view
    }()
    
    var filterByButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.setTitle("Beer Style", for: .normal)
        view.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.3
        view.addTarget(self, action: #selector(HomeVC.filterByButtonTapped), for: .touchUpInside)
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
        view.addSubview(sortByButton)
        view.addSubview(filterByButton)
      
        
        mainTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor , constant: -60).isActive = true
        
        searchController.searchBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        mainTable.tableHeaderView = searchController.searchBar
        
        sortByButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        sortByButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sortByButton.widthAnchor.constraint(equalToConstant: (view.frame.width)/2 - 15).isActive = true
        sortByButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        filterByButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        filterByButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        filterByButton.widthAnchor.constraint(equalToConstant: (view.frame.width)/2 - 15).isActive = true
        filterByButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            
    }
}
