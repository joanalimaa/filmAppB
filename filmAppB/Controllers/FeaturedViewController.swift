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
    
    
    
    //Adicionar aqui o Upcoming
    
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
        
        func trendingTodayAPI() async -> [Movie]{
            var components = Movie.urlComponents
            components.path = "/3/trending/movie/day"
            components.queryItems = [
                URLQueryItem(name: "api_key", value: Movie.apiKey)
            ]
            //queryItems query é o que ta chamando do servidor. Sao os ítens que estao passando a mais
            
            let session = URLSession.shared
            // acessar coisas da internet. Gerenciador de acesso a rede (URLSession)
            
            do {
                let (data, response) = try await session.data(from: components.url!)
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movieResult = try decoder.decode(MovieResponse.self, from: data)
                
                return movieResult.results
                
            } catch {
                print(error)
            }
            
            return []
        }
        
        func trendingThisWeekAPI() async -> [Movie]{
            var components = Movie.urlComponents
            components.path = "/3/trending/movie/week"
            components.queryItems = [
                URLQueryItem(name: "api_key", value: Movie.apiKey)
            ]
            //queryItems query é o que ta chamando do servidor. Sao os ítens que estao passando a mais
            
            let session = URLSession.shared
            // acessar coisas da internet. Gerenciador de acesso a rede (URLSession)
            
            do {
                let (data, response) = try await session.data(from: components.url!)
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movieResult = try decoder.decode(MovieResponse.self, from: data)
                
                return movieResult.results
                
            } catch {
                print(error)
            }
            
            return []
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
            
        }
    }
    
}

