//
//  MovieListVC +TableView.swift
//  Saba_Khitaridze_Task_15
//
//  Created by Saba Khitaridze on 14.07.22.
//

import UIKit


extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? movies.count : watchedMovies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
            if let movieCell = cell {
                let currentMovie = movies[indexPath.row]
                movieCell.configureCell(for: currentMovie)
                movieCell.delegate = self
                return movieCell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
            if let seenMovieCell = cell {
                let currentSeenMovies = watchedMovies[indexPath.row]
                seenMovieCell.configureCell(for: currentSeenMovies)
                unSeenMovie(with: seenMovieCell)
                
                return seenMovieCell
            }
        }
        return UITableViewCell()
    }
    
    //unSeenMovie helper
    private func unSeenMovie(with cell: MovieCell) {
        cell.unSeenMovie = { currentCell in
            if let indexPath = self.moviesTableView.indexPath(for: currentCell) {
                if let movieToUnseen = self.allMovies.firstIndex(where: {$0.title == self.watchedMovies[indexPath.row].title}) {
                    self.allMovies[movieToUnseen].seen = false
                    }
                self.updateTableView()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailsVC.identifier) as? DetailsVC
        guard let destinationVC = vc else { return }
        indexPath.section == 0 ? open(movie: movies[indexPath.row], on: destinationVC) : open(movie: watchedMovies[indexPath.row], on: destinationVC)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    //helper method for didSelect
    private func open(movie: Movie, on vc: DetailsVC) {
        vc.movie = movie
        vc.delegate = self
        vc.genreMovies = allMovies.filter({ $0.genre == movie.genre && $0.title != movie.title })
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UINib(nibName: HeaderView.identifier, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? HeaderView
        guard let headerView = view else { return UIView() }
        headerView.configureView(for: section)
        
        section == 1 && isFavouriteSelected ? headerView.favouritesBtn.toggleBackgroundColor(with: headerView.watchlistOrWatchedMovieBtn) : headerView.watchlistOrWatchedMovieBtn.toggleBackgroundColor(with: headerView.favouritesBtn)
            
        headerView.delegate = self
        
        return headerView
    }
}
