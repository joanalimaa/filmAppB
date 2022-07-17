//
//  FeaturedViewController+UICollectionViewDataSource.swift
//  AgoraVai1
//
//  Created by Joana Lima on 12/07/22.
//

import UIKit

extension FeaturedViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.popularCollectionView{
            return popularMovies.count
        } else if collectionView == self.nowPlayingCollectionView{
            return popularMovies.count
        } else {
            return 0
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.popularCollectionView{
            
            return makePopularCell(indexPath)
            
        } else if collectionView == self.nowPlayingCollectionView{
            return makeNowPlaying(indexPath)
        } else {
            return UICollectionViewCell()
        }
    }
    
    fileprivate func makePopularCell(_ indexPath: IndexPath) -> PopularCollectionViewCell {
        let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.cellIdentifier, for: indexPath) as? PopularCollectionViewCell
        
        cell?.setup(title: popularMovies[indexPath.item].title, image: UIImage(named: popularMovies[indexPath.item].backdropPath) ?? UIImage())
        
        return cell ?? PopularCollectionViewCell()
    }
    
    
    fileprivate func makeNowPlaying(_ indexPath: IndexPath) -> NowPlayingCollectionViewCell {
        let cell = nowPlayingCollectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCollectionViewCell.cellIdentifier, for: indexPath) as? NowPlayingCollectionViewCell
        
        let year: String = String(nowPlayingMovies[indexPath.item].releaseDate.prefix(4))
                            //"\(nowPlayingMovies[indexPath.item].releaseDate.prefix(4))" outra forma de transformar a substring em uma string
                            //Formata o year pra gente so precisar chamar a propria variavel ao inves de ter q escrever tudo
        
        cell?.setup(title: nowPlayingMovies[indexPath.item].title,
                    year: year,
                    image: UIImage(named: nowPlayingMovies[indexPath.item].posterPath) ?? UIImage())
    
        
        return cell ?? NowPlayingCollectionViewCell()
    }
    
    
    
    
}
