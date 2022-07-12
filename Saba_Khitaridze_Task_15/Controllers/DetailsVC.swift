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

    //MARK: - IBOutlet
    @IBOutlet weak var movieInfoView: UIView!
    
    //MARK: - IBOutlets
     @IBOutlet weak var movieTitleLabel: UILabel!
     @IBOutlet weak var addToFavouritesBtn: UIButton!
     @IBOutlet weak var imdbRankLabel: UILabel!
     @IBOutlet weak var releaseDateLabel: UILabel!
     @IBOutlet weak var mainActorLabel: UILabel!
     @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: - Vars
    static let identifier = "DetailsVC"
    var delegate: AddToFavouritesDelegate?
    
    var movieTitle = ""
    var imdbRank = ""
    var releaseDate = ""
    var mainActor = ""
    var descriptionText = ""
    var movie: Movie?
    var isFavourite = false
    var delegateClosure: ((DetailsVC) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTitleLabel.text = movieTitle
        imdbRankLabel.text = imdbRank
        releaseDateLabel.text = releaseDate
        mainActorLabel.text = mainActor
        descriptionLabel.text = descriptionText
        delegateClosure?(self)
        if isFavourite {
            addToFavouritesBtn.backgroundColor = .systemYellow
            addToFavouritesBtn.setTitle("Added", for: .normal)
        }
    }
    
    
    @IBAction func addToFavourites(_ sender: UIButton) {
        delegate?.markFavouriteMovie(from: self)
    }
}
