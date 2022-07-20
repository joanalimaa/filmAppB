//
//  SearchMoviesCollectionViewCell.swift
//  filmAppB
//
//  Created by Joana Lima on 19/07/22.
//

import UIKit

class SearchMoviesCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "searchCell"
        
        @IBOutlet var imageView: UIImageView!
    
        
        func setup(image: UIImage) {
            imageView.image = image
        }
    
}
