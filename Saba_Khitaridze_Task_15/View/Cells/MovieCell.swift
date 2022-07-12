//
//  MovieCell.swift
//  Saba_Khitaridze_Task_15
//
//  Created by Saba Khitaridze on 12.07.22.
//

import UIKit

protocol SeenMovieDelegate {
    func markSeenMovie(with cell: MovieCell)
}


class MovieCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var imdbRankLabel: UILabel!
    @IBOutlet weak var seenButton: UIButton! {
        didSet {
            seenButton.layer.cornerRadius = 10
        }
    }
    
    //MARK: - Vars
    static let identifier = "MovieCell"
    
    var delegate: SeenMovieDelegate?
    var unSeenMovie: ((MovieCell) -> ())?
    
    //MARK: - Cell Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    //MARK: - IBAction
    @IBAction func seenButtonPressed(_ sender: UIButton) {
        sender.backgroundColor == .lightGray ? delegate?.markSeenMovie(with: self) : unSeenMovie?(self)
    }
    
    //MARK: - Method
    
    func configureCell(for movie: Movie) {
        movieTitleLabel.text = movie.title
        imdbRankLabel.text = "\(movie.imdb)"
        seenButton.backgroundColor = movie.seen == true ? .systemBlue : .lightGray
    }
}
