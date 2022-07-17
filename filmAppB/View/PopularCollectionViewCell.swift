//
//  PopularCollectionViewCell.swift
//  AgoraVai1
//
//  Created by Alessandra Pereira on 11/07/22.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "popularCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    func setup(title: String, image: UIImage){
        titleLabel.text = title
        imageView.image = image  //a celular se constroi sozinha pegando as infromaçoes e colocando na view
        
    }
}
