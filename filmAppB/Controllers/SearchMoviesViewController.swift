//
//  SearchViewController.swift
//  filmAppB
//
//  Created by Joana Lima on 19/07/22.
//

import UIKit

class SearchMoviesViewController: UIViewController, UISearchBarDelegate{//, UISearchResultsUpdating {
    
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchMoviesCollectionView: UICollectionView!
    
    
    var searchMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        //        navigationItem.searchController = self
        searchMoviesCollectionView.dataSource = self
        searchMoviesCollectionView.delegate = self
        searchBar.delegate = self
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        print(query)
        Task {
            self.searchMovies = await Movie.searchMoviesAPI(query: query)
            print("query:\(query)")
            print(searchMovies.count)
            print(searchMovies)
            self.searchMoviesCollectionView.reloadData()

        }
    }
    
    
}

extension SearchMoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? SearchMoviesCollectionViewCell
        let movie = searchMovies[indexPath.item]
        
        Task{
            let imageData = await Movie.downloadImageData(withPath: movie.posterPath ?? "")
            let image = UIImage(data: imageData) ?? UIImage()
            
            cell?.setup(image: image)
        }
        
        return cell ?? SearchMoviesCollectionViewCell()
        
        
    }
}
