//
//  HeaderView.swift
//  Saba_Khitaridze_Task_15
//
//  Created by Saba Khitaridze on 12.07.22.
//

import UIKit

protocol FilterMovieDelegate {
    func getFavouriteMovies()
    func getWatchedMovies()
}

class HeaderView: UIView {

    //MARK: - IBOutlets
    @IBOutlet weak var watchlistOrWatchedMovieBtn: UIButton!
    @IBOutlet weak var favouritesBtn: UIButton!
    
    
    //MARK: - Vars
    static let identifier = "HeaderView"
    var delegate: FilterMovieDelegate?
    
    
    //MARK: - IBActions
    @IBAction func watchlistBtnPressed(_ sender: UIButton) {
        watchlistOrWatchedMovieBtn.toggleBackgroundColor(with: favouritesBtn)
        delegate?.getWatchedMovies()
    }
    
    @IBAction func favouritesBtnPressed(_ sender: UIButton) {
        favouritesBtn.toggleBackgroundColor(with: watchlistOrWatchedMovieBtn)
        delegate?.getFavouriteMovies()
    }
    
    
    //MARK: - Methods
    func configureView(for section: Int) {
        if section == 0 {
            watchlistOrWatchedMovieBtn.setTitle("Watchlist", for: .normal)
            favouritesBtn.isHidden = true
        } else {
            watchlistOrWatchedMovieBtn.setTitle("Watched", for: .normal)
            favouritesBtn.isHidden = false
        }
    }
}


//ამ მეთოდით button-ებს background უნდა შეეცვალათ დაჭერის მიხედვით, რომ ადვილი მისახვედრი ყოფილიყო watched სექციაში ვართ თუ Favourites, მაგრამ დელეგატების გამოყენების შემდეგ აღარ ფუნქციონირებდა :/ სავარაუდოდ tableView-ს რომ ვარილოუდებ მაგის ბრალია
extension UIButton {
    func toggleBackgroundColor(with button: UIButton) {
        self.backgroundColor = .systemBlue
        button.backgroundColor = .white
    }
}
