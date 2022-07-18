//
//  UpcomingCollectionViewCell.swift
//  filmAppB
//
//  Created by Joana Lima on 18/07/22.
//

import UIKit

class UpcomingCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "upcomingCell"
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var date: UILabel!
    
    func setup(title: String, year: String, image: UIImage){
        titleLabel.text = title
        date.text = year
        imageView.image = image
    }
    
}
