//
//  DetailsViewController.swift
//  AgoraVai1
//
//  Created by Joana Lima on 13/07/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
   
    @IBOutlet var backdropImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    
    
    
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()

        //print(movie)
        
        
    
        guard let movie = movie else{
            return
        }
        
        title = movie.title
        
        Task{
            let imageData = await Movie.downloadImageData(withPath: (movie.backdropPath ?? ""))
            let image = UIImage(data: imageData) ?? UIImage()
            backdropImage.image = image
        }
        
        titleLabel.text = movie.title
        
        Task{
            let imageData = await Movie.downloadImageData(withPath: (movie.posterPath ?? ""))
            let image = UIImage(data: imageData) ?? UIImage()
            posterImage.image = image
        }
        
        
//        title = movie.title
//        backdropImage.image = UIImage(named: movie.backdropPath)
//        titleLabel.text = movie.title
//        posterImage.image = UIImage(named: movie.posterPath)
//
        ratingLabel.text = "Rating: \(movie.voteAverage)/10"
        overviewLabel.text = movie.overview
        
    }
    

    

}
