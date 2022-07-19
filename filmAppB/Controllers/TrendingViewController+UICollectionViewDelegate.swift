//
//  TrendingViewController+UICollectionViewDelegate.swift
//  filmAppB
//
//  Created by Joana Lima on 18/07/22.
//

import UIKit

extension TrendingViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let movieToday: Movie = trendingTodayMovies[indexPath.row]
        let movieThisWeek: Movie = trendingThisWeekMovies[indexPath.row]
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            return self.performSegue(withIdentifier: "detailsSegue", sender: movieToday)
        case 1:
            return self.performSegue(withIdentifier: "detailsSegue", sender: movieThisWeek)
        default:
            break
        }
        
        
//        self.performSegue(withIdentifier: "detailSegue", sender: movie)
    }
    
}
