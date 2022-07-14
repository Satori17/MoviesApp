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
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    //MARK: - Vars
    var allMovies = Movie.allMovies
    lazy var movies = allMovies
    var watchedMovies = [Movie]()
    var watchedMoviesStorage = [Movie]()
    
    //vars for genre sorting
    var moviesByGenres = [String: [Movie]]()
    let genreNames = Genre.allCases
    
    //MARK: -  View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
    }
    
    
    //MARK: - Methods
    private func setCollectionView() {
        //registering cell
        moviesCollectionView.registerNib(class: GenreCell.self)
        //flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.scrollDirection = .horizontal
        moviesCollectionView.collectionViewLayout = flowLayout
        //data
        updateMovieListByGenres()
    }
    
    private func updateMovieListByGenres() {
        moviesByGenres = [Genre.All.rawValue: movies,
                          Genre.Comedy.rawValue: movies.filter({$0.genre == .Comedy}),
                          Genre.Action.rawValue: movies.filter({$0.genre == .Action}),
                          Genre.Drama.rawValue: movies.filter({$0.genre == .Drama})]
    }
}

//MARK: - Protocols

extension MovieListVC: SeenMovieDelegate, FilterMovieDelegate, AddToFavouritesDelegate  {
    
    func markSeenMovie(with cell: MovieCell) {
        if let indexPath = moviesTableView.indexPath(for: cell) {
            allMovies[indexPath.row].seen = true
            var seenMovie = movies.remove(at: indexPath.row)
            seenMovie.seen = true
            updateMovieListByGenres()
            watchedMovies.append(seenMovie)
            watchedMoviesStorage.append(seenMovie)
            moviesTableView.reloadData()
        }
    }
    
    func getFavouriteMovies() {       
        watchedMovies = watchedMovies.filter({$0.isFavourite})
        moviesTableView.reloadData()
    }
    
    func getWatchedMovies() {
        watchedMovies = watchedMoviesStorage
        moviesTableView.reloadData()
    }
    
    func markFavouriteMovie(from vc: DetailsVC) {
        vc.addToFavouritesBtn.backgroundColor = .systemYellow
        vc.addToFavouritesBtn.setTitle("Added", for: .normal)
        if let movie = vc.movie {
            if let currentMovie = watchedMovies.firstIndex(where: {$0.title == movie.title}) {
                watchedMovies[currentMovie].isFavourite = true
                watchedMoviesStorage[currentMovie].isFavourite = true
            }
        }
        moviesTableView.reloadData()
    }
}
