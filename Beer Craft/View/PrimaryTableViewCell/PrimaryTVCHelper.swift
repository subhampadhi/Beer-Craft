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
        return cell
    }
    
}
