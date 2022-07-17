//
//  FeaturedViewController+UICollectionViewDelegate.swift
//  AgoraVai1
//
//  Created by Joana Lima on 13/07/22.
//

import UIKit

extension FeaturedViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie: Movie
        if collectionView == popularCollectionView{
            movie = popularMovies[indexPath.item] //index path diz onde estamos, o indice da celular tocada
        } else{
            movie = nowPlayingMovies[indexPath.item]
        }
        self.performSegue(withIdentifier: "detailsSegue", sender: movie)
    }
}
