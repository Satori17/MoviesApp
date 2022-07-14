//
//  GenreCell.swift
//  Saba_Khitaridze_Task_15
//
//  Created by Saba Khitaridze on 14.07.22.
//

import UIKit

class GenreCell: UICollectionViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var genreLabel: UILabel! {
        didSet {
            genreLabel.textColor = .white
        }
    }
    
    //MARK: - Vars
    let identifier = "GenreCell"
    
    //MARK: - Cell Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
    }
}
