//
//  MovieListVC+CollectionView.swift
//  Saba_Khitaridze_Task_15
//
//  Created by Saba Khitaridze on 14.07.22.
//

import UIKit


extension MovieListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moviesByGenres.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as? GenreCell
        if let genreCell = cell {
            genreCell.genreLabel.text = "\(genreNames[indexPath.row])"
            
            return genreCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? GenreCell {
            moviesTableView.isUserInteractionEnabled = indexPath.row == 0
            cell.backgroundColor = .white
            cell.genreLabel.textColor = .systemBlue
           }
                
        //for watchlist movies
        movies = moviesByGenres[genreNames[indexPath.row].rawValue]!.filter({!$0.seen})                
        //for watched movies
        watchedMovies = watchedMoviesStorage
        watchedMovies = genreNames[indexPath.row].rawValue == "All" ? watchedMoviesStorage : watchedMovies.filter({$0.genre.rawValue == genreNames[indexPath.row].rawValue})
        
        moviesTableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? GenreCell {
            cell.backgroundColor = .systemBlue
            cell.genreLabel.textColor = .white
           }
    }
    
    //Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height)
    }
}
