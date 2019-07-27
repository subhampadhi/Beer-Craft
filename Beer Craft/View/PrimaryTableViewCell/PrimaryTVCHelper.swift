//
//  PrimaryTVCHelper.swift
//  Beer Craft
//
//  Created by Subham Padhi on 27/07/19.
//  Copyright © 2019 Subham Padhi. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class PrimaryTVCHelper {
    
    let leadingImage: UIImage
    let topLabelText: String
    let bottomLabelText: String
    let percentLabelText:String
    var plusTapped: ((Int)->())?
    var miunsTapped: ((Int)->())?
    var orderCount: Int = 0
    
    init(leadingImage: UIImage, topLabelText: String, bottomLabelText: String, percentLabelText: String) {
    
        self.leadingImage = leadingImage
        self.topLabelText = topLabelText
        self.bottomLabelText = bottomLabelText
        self.percentLabelText = percentLabelText
    }
}

extension PrimaryTVCHelper: CellFunctions {
    static func registerCell(tableView: UITableView) {
        tableView.register(PrimaryTableViewCell.self, forCellReuseIdentifier: "primaryTableViewCell")
    }
    
    func cellInstantiate(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "primaryTableViewCell", for: indexPath) as! PrimaryTableViewCell
        cell.topLabel.text = topLabelText
        cell.bottomLabel.text = bottomLabelText
        cell.percentLabel.text = percentLabelText
        cell.leadingImage.image = #imageLiteral(resourceName: "beer_Image")
        cell.selectionStyle = .none
        cell.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1)
        if self.orderCount > 0 {
            cell.orderCountLabel.text = "\(orderCount)"
            cell.orderCountLabel.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        } else {
            self.orderCount = 0
            cell.orderCountLabel.text = ""
        }
        cell.plusTappedClosure = { () in
            self.plusTapped?(indexPath.row)
        }
        cell.minusTappedClosure = { () in
            self.miunsTapped?(indexPath.row)
        }
        return cell
    }
    
}
