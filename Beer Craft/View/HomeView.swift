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
    
    var refreshControl = UIRefreshControl()
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
        view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
    
    func setupBarButton() {
        
        let button = UIButton.init(type: .custom)
        button.setImage(#imageLiteral(resourceName: "cart_empty"), for: .normal)
        button.addTarget(self, action:#selector(HomeVC.addTapped), for:.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func pullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(HomeVC.refresh), for: UIControl.Event.valueChanged)
        mainTable.addSubview(refreshControl)
    }
    
    func setUpNavBar()  {
        navigationItem.title = "B E E R C R A F T"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.init(red: 232/255, green: 157/255, blue: 57/255, alpha: 1),
                              NSAttributedString.Key.font:UIFont.systemFont(ofSize: 24, weight: .heavy)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let attr =  [NSAttributedString.Key.foregroundColor:UIColor.init(red: 232/255, green: 157/255, blue: 57/255, alpha: 1),
                     NSAttributedString.Key.font:UIFont.systemFont(ofSize: 32, weight: .heavy)]
        navigationController?.navigationBar.largeTitleTextAttributes = attr
    }
    
    func setUpSearchBar() {
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.barStyle = .default
        searchController.searchBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        searchController.searchBar.isTranslucent = false
        searchController.searchBar.searchBarStyle = .minimal
        self.navigationItem.searchController = searchController
    }
    
    func initViews() {
        
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        setUpNavBar()
        setupBarButton()
        setUpSearchBar()
        pullToRefresh()
        
        view.addSubview(mainTable)
        view.addSubview(sortByButton)
        view.addSubview(filterByButton)
        view.addSubview(separatorView)
      
        mainTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor , constant: -60).isActive = true
        
        sortByButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        sortByButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sortByButton.widthAnchor.constraint(equalToConstant: (view.frame.width)/2 - 15).isActive = true
        sortByButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        filterByButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        filterByButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        filterByButton.widthAnchor.constraint(equalToConstant: (view.frame.width)/2 - 15).isActive = true
        filterByButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 10).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -10).isActive = true
        separatorView.topAnchor.constraint(equalTo: mainTable.bottomAnchor , constant: 2).isActive = true
        separatorView.layer.borderWidth = 5
    }
}
