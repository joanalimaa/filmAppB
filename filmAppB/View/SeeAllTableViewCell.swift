//
//  SeeAllTableViewCell.swift
//  filmAppB
//
//  Created by Joana Lima on 19/07/22.
//

import UIKit

class SeeAllTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "seeAllCell"
    
    @IBOutlet var imageViewSeeAll: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    
    func setup(title: String, image: UIImage, year: String, rating: String){
        imageViewSeeAll.image = image
        titleLabel.text = title
        dateLabel.text = year
        ratingLabel.text = rating
        
    }

}
