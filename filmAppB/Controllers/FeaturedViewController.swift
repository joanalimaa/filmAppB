//
//  FeaturedViewController.swift
//  AgoraVai1
//
//  Created by Alessandra Pereira on 05/07/22.
//

import UIKit

class FeaturedViewController: UIViewController, UICollectionViewDataSource {
    
    var popularMovies: [Movie] = [] //Movie.popularMovies()
    var nowPlayingMovies: [Movie] = []
    var upcomingMovies: [Movie] = []
    
    
    
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    
    
    
    //Buttons do See All
    @IBOutlet var popularSeeAll: UIButton!
    @IBOutlet var nowPlayingSeeAll: UIButton!
    @IBOutlet var upcomingSeeAll: UIButton!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
        
        nowPlayingCollectionView.dataSource = self
        nowPlayingCollectionView.delegate = self
        
        upcomingCollectionView.dataSource = self
        upcomingCollectionView.delegate = self
        
        Task {
            popularMovies = await Movie.popularMoviesAPI()
            self.popularCollectionView.reloadData() //Carrega sem nada oq la em cima [] ta vazio e ai recarrega pra mostrar as coisas
            
        }
        
        Task {
            nowPlayingMovies = await Movie.nowPlayingMoviesAPI()
            self.nowPlayingCollectionView.reloadData()
        }
        
        
        
        Task {
            upcomingMovies = await Movie.upcomingMoviesAPI()
            self.upcomingCollectionView.reloadData()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController{
            let movie = sender as? Movie
            destination.movie = movie
            
        } else if let destination = segue.destination as? SeeAllViewController,
                       let button = sender as? UIButton{
               if button == popularSeeAll {
                   destination.movies = popularMovies
                   destination.title = "Popular"
               } else if button == nowPlayingSeeAll{
                   destination.movies = nowPlayingMovies
                   destination.title = "Now Playing"
               } else{
                   destination.movies = upcomingMovies
                   destination.title = "Upcoming"
               }
           }
    }
    
}

