//
//  TrendingViewController.swift
//  filmAppB
//
//  Created by Joana Lima on 18/07/22.
//

import UIKit

class TrendingViewController: UIViewController{
    
    var trendingTodayMovies: [Movie] = []
    var trendingThisWeekMovies: [Movie] = []
    
    
    @IBOutlet var trendingTableView: UITableView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        trendingTableView.dataSource = self
        trendingTableView.delegate = self
        
        Task {
            trendingTodayMovies = await Movie.trendingTodayAPI()
            self.trendingTableView.reloadData()
        }
        
        Task {
            trendingThisWeekMovies = await Movie.trendingThisWeekAPI()
            self.trendingTableView.reloadData()
        }
        
        
    }
    
    @IBAction func segmentedChanged(_ sender: Any) {
        trendingTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController{
            let movie = sender as? Movie
            destination.movie = movie
        }
        
        
    }
}


    

    
    
