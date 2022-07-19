//
//  TrendingTableViewCell.swift
//  filmAppB
//
//  Created by Joana Lima on 19/07/22.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "trendingTableViewCell"
    
    @IBOutlet var imageTableViewCell: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    func setup(title: String, image: UIImage, year: String){
        titleLabel.text = title
        dateLabel.text = year
        imageTableViewCell.image = image
    }
    

    
}
