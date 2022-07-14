//
//  DetailsVC.swift
//  Saba_Khitaridze_Task_15
//
//  Created by Saba Khitaridze on 12.07.22.
//

import UIKit

protocol AddToFavouritesDelegate {
    func markFavouriteMovie(from vc: DetailsVC)
}

class DetailsVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var movieInfoView: UIView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var addToFavouritesBtn: UIButton! {
        didSet {
            if let movie = movie {
                guard movie.seen else {
                    addToFavouritesBtn.isHidden = true
                    return
                }
                if movie.isFavourite {
                    addToFavouritesBtn.isHidden = false
                    addToFavouritesBtn.backgroundColor = .systemYellow
                    addToFavouritesBtn.setTitle("Added", for: .normal)
                } else {
                    addToFavouritesBtn.backgroundColor = .lightGray
                    addToFavouritesBtn.setTitle("Add to Favourites", for: .normal)
                }
            }
        }
    }
    @IBOutlet weak var imdbRankLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var mainActorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var genreMoviesCollectionView: UICollectionView!
    
    
    //MARK: - Vars
    static let identifier = "DetailsVC"
    
    var delegate: AddToFavouritesDelegate?
    var movie: Movie?
    var genreMovies = [Movie]()
    
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        setCollectionView()
    }
    
    //MARK: - Methods
    
    func configureVC() {
        guard let openedMovie = movie else { return }
        movieTitleLabel.text = openedMovie.title
        imdbRankLabel.text = "\(openedMovie.imdb)"
        releaseDateLabel.text = openedMovie.releaseDate
        mainActorLabel.text = openedMovie.mainActor
        descriptionLabel.text = openedMovie.description
    }
    
    private func setCollectionView() {
        //registering cell
        genreMoviesCollectionView.registerNib(class: GenreCell.self)
        //cell flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 5
        flowLayout.scrollDirection = .horizontal
        genreMoviesCollectionView.collectionViewLayout = flowLayout
    }
    
    //MARK: - IBAction
    
    @IBAction func addToFavourites(_ sender: UIButton) {
        delegate?.markFavouriteMovie(from: self)
    }
}
