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
    lazy var movies = allMovies.filter({!$0.seen})
    lazy var watchedMovies = allMovies.filter({$0.seen})
    
    var isFavouriteSelected = false
    
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
                          Genre.Comedy.rawValue: allMovies.filter({$0.genre == .Comedy}),
                          Genre.Action.rawValue: allMovies.filter({$0.genre == .Action}),
                          Genre.Drama.rawValue: allMovies.filter({$0.genre == .Drama})]
    }
    
    func updateTableView() {
        movies = allMovies.filter({!$0.seen})
        watchedMovies = allMovies.filter({$0.seen})
        moviesTableView.reloadData()
    }
}

//MARK: - Protocols

extension MovieListVC: SeenMovieDelegate, FilterMovieDelegate, AddToFavouritesDelegate  {
    
    func markSeenMovie(with cell: MovieCell) {
        if let indexPath = moviesTableView.indexPath(for: cell) {
            if let currentMovie = allMovies.firstIndex(where: {$0.title == movies[indexPath.row].title}) {
                allMovies[currentMovie].seen = true
            }
            
            updateMovieListByGenres()
            updateTableView()
        }
    }
    
    func getFavouriteMovies() {       
        watchedMovies = allMovies.filter({$0.isFavourite})
        isFavouriteSelected = true
        moviesTableView.reloadData()
    }
    
    func getWatchedMovies() {
        watchedMovies = allMovies.filter({$0.seen})
        isFavouriteSelected = false
        moviesTableView.reloadData()
    }
    
    func markFavouriteMovie(from vc: DetailsVC) {
        vc.addToFavouritesBtn.backgroundColor = .systemYellow
        vc.addToFavouritesBtn.setTitle("Added", for: .normal)
        if let movie = vc.movie {
            if let currentMovie = allMovies.firstIndex(where: {$0.title == movie.title}) {
                allMovies[currentMovie].isFavourite = true
            }
        }
        moviesTableView.reloadData()
    }
}
