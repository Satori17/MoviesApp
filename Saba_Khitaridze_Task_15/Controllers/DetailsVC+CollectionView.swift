//
//  DetailsVC+CollectionView.swift
//  Saba_Khitaridze_Task_15
//
//  Created by Saba Khitaridze on 14.07.22.
//

import UIKit

extension DetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genreMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as? GenreCell
        if let genreMovieCell = cell {
            genreMovieCell.isSelected = true
            genreMovieCell.genreLabel.sizeToFit()
            genreMovieCell.genreLabel.text = genreMovies[indexPath.row].title
            
            return genreMovieCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movie = genreMovies[indexPath.row]
        addToFavouritesBtn.isHidden = true
        configureVC()        
    }
    
    //flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height-20)
    }
}
