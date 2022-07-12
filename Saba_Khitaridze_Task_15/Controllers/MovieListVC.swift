//
//  MovieListVC.swift
//  Saba_Khitaridze_Task_15
//
//  Created by Saba Khitaridze on 11.07.22.
//

import UIKit


class MovieListVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var moviesTableView: UITableView!
    
    //MARK: - Vars
    
    var movies = Movie.allMovies
    var watchedMovies = [Movie]()
    var WatchedMovieStorage = [Movie]()
    var favouriteMovies = [Movie]()
    
    //MARK: -  View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


//MARK: - Protocols

extension MovieListVC: SeenMovieDelegate, FilterMovieDelegate , AddToFavouritesDelegate  {
    
    func markSeenMovie(with cell: MovieCell) {
        if let indexPath = moviesTableView.indexPath(for: cell) {
            var seenMovie = movies.remove(at: indexPath.row)
            seenMovie.seen = true
            watchedMovies.append(seenMovie)
            WatchedMovieStorage = watchedMovies
            moviesTableView.reloadData()
        }
    }
    
    func getFavouriteMovies() {
        watchedMovies = favouriteMovies
        moviesTableView.reloadData()
    }
    
    func getWatchedMovies() {
        watchedMovies = WatchedMovieStorage
        moviesTableView.reloadData()
    }
    
    func markFavouriteMovie(from vc: DetailsVC) {
        vc.addToFavouritesBtn.backgroundColor = .systemYellow
        vc.addToFavouritesBtn.setTitle("Added", for: .normal)
        if var movie = vc.movie {
            favouriteMovies.append(movie)
            watchedMovies.removeAll(where: {$0 == movie})
            favouriteMovies.removeAll(where: {$0 == movie})
            movie.isFavourite = true
            watchedMovies.insert(movie, at: 0)
            favouriteMovies.insert(movie, at: 0)
        }
        moviesTableView.reloadData()
    }    
}


//MARK: - Tableview Delegate & DataSource

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
                let currentMovie = movies.sorted()[indexPath.row]
                movieCell.configureCell(for: currentMovie)
                movieCell.delegate = self
                return movieCell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
            if let seenMovieCell = cell {
                let currentSeenMovies = watchedMovies[indexPath.row]
                seenMovieCell.configureCell(for: currentSeenMovies)
                //unseen movie
                seenMovieCell.unSeenMovie = { currentCell in
                    if let indexPath = self.moviesTableView.indexPath(for: currentCell) {
                        var unSeenMovie = self.watchedMovies.remove(at: indexPath.row)
                        unSeenMovie.seen = false
                        self.movies.append(unSeenMovie)
                        self.moviesTableView.reloadData()
                    }
                }
                return seenMovieCell
            }
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailsVC.identifier) as? DetailsVC
        guard let destinationVC = vc else { return }
        indexPath.section == 0 ? open(movie: movies[indexPath.row], on: destinationVC) : open(movie: watchedMovies[indexPath.row], on: destinationVC)
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    //helper method for didSelect
    private func open(movie: Movie, on vc: DetailsVC) {
        vc.movieTitle = movie.title
        vc.imdbRank = "\(movie.imdb)"
        vc.releaseDate = movie.releaseDate
        vc.mainActor = movie.mainActor
        vc.descriptionText = movie.description
        vc.isFavourite = movie.isFavourite
        vc.movie = movie
        vc.delegate = self
        vc.delegateClosure = { vc in
            guard movie.seen == true else {
                vc.addToFavouritesBtn.isHidden = true
                return
            }
            if movie.isFavourite == true {
            vc.addToFavouritesBtn.isHidden = false
                vc.addToFavouritesBtn.backgroundColor = .systemYellow
                vc.addToFavouritesBtn.setTitle("Added", for: .normal)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UINib(nibName: HeaderView.identifier, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? HeaderView
        guard let headerView = view else { return UIView() }
        headerView.configureView(for: section)
        headerView.delegate = self
        
        return headerView
    }
}
