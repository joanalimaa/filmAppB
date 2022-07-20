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
        } else if collectionView == self.upcomingCollectionView{
            return upcomingMovies.count
        } else {
            return 0
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.popularCollectionView{
            
            return makePopular(indexPath)
            
        } else if collectionView == self.nowPlayingCollectionView{
            return makeNowPlaying(indexPath)
            
        } else if collectionView == self.upcomingCollectionView{
            return makeUpcoming(indexPath)
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    
    fileprivate func makePopular(_ indexPath: IndexPath) -> PopularCollectionViewCell {
        let cell = popularCollectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.cellIdentifier, for: indexPath) as? PopularCollectionViewCell
        
       
        let movie = popularMovies[indexPath.item]
        cell?.setup(title: movie.title, image: UIImage()) //Chama apenas a imagem vazia pra esperar baixar e depois que baixar preenche a imagem na celula
        
        Task { //fica sempre em segundo plano
            let imageData = await Movie.downloadImageData(withPath: (movie.backdropPath ?? ""))
            let imagem: UIImage = UIImage(data: imageData) ?? UIImage()  //Utiliza os dados baixados e cria uma imagem / Poderiamos colocar algo dentro da imagem vazia como placeholder pra n ficar simplesmente um bloco vazio sem nada e da a impressao de que o app crashou e n que ocorreu algum outro erro
            
            cell?.setup(title: movie.title, image: imagem)
        }
        
        
        
        return cell ?? PopularCollectionViewCell()
    }
    
    
    
    
    //MARK: Config NowPlaying
    
    
    fileprivate func makeNowPlaying(_ indexPath: IndexPath) -> NowPlayingCollectionViewCell {
        let cell = nowPlayingCollectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCollectionViewCell.cellIdentifier, for: indexPath) as? NowPlayingCollectionViewCell
        
        let year: String = String(nowPlayingMovies[indexPath.item].releaseDate.prefix(4))
                            //"\(nowPlayingMovies[indexPath.item].releaseDate.prefix(4))" outra forma de transformar a substring em uma string
                            //Formata o year pra gente so precisar chamar a propria variavel ao inves de ter q escrever tudo
       
        let movie = nowPlayingMovies[indexPath.item]
        cell?.setup(title: movie.title, year: year, image: UIImage())
        
        
        Task{
            let imageData = await Movie.downloadImageData(withPath: (movie.posterPath ?? ""))
            let imagem: UIImage = UIImage(data: imageData) ?? UIImage()
            cell?.setup(title: movie.title, year: year, image: imagem)
        }
    
        
        return cell ?? NowPlayingCollectionViewCell()
    }
    
    
    
    //MARK: Config Upcoming
    
    fileprivate func makeUpcoming(_ indexPath: IndexPath) -> UpcomingCollectionViewCell {
        let cell = upcomingCollectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell.cellIdentifier, for: indexPath) as? UpcomingCollectionViewCell
        
       
        let year: String = String(upcomingMovies[indexPath.item].releaseDate.prefix(4))
        let movie = upcomingMovies[indexPath.item]
        cell?.setup(title: movie.title, year: year, image: UIImage())
        
        
        Task{
            let imageData = await Movie.downloadImageData(withPath: (movie.posterPath ?? ""))
            let imagem: UIImage = UIImage(data: imageData) ?? UIImage()
            cell?.setup(title: movie.title, year: year, image: imagem)
        }
        
        return cell ?? UpcomingCollectionViewCell()
    }
    
    
    
    
    
    
    
}
