//
//  TrendingViewController+UICollectionViewDataSource.swift
//  filmAppB
//
//  Created by Joana Lima on 18/07/22.
//

import UIKit

extension TrendingViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return trendingTodayMovies.count
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return trendingTodayMovies.count
        case 1:
            return trendingThisWeekMovies.count
        default:
            break
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trendingTableViewCell") as? TrendingTableViewCell
        
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let movie = trendingTodayMovies[indexPath.item]
            
            Task {
                let imageData = await Movie.downloadImageData(withPath: (movie.posterPath ?? ""))
                let image = UIImage(data: imageData) ?? UIImage()
                let year: String = "\(movie.releaseDate.prefix(4))"
                cell?.setup(title: movie.title, image: image, year: year)
        
            }
        
        case 1:
            let movie = trendingThisWeekMovies[indexPath.item]
            
            Task {
                let imageData = await Movie.downloadImageData(withPath: (movie.posterPath ?? ""))
                let image = UIImage(data: imageData) ?? UIImage()
                let year: String = "\(movie.releaseDate.prefix(4))"
                cell?.setup(title: movie.title, image: image, year: year)
            }
            
        default:
            break
        }
        
        return cell ?? TrendingTableViewCell()
    }
    
}
