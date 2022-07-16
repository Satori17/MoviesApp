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
    
    override var isSelected: Bool {
        willSet {
            if isSelected {
                self.backgroundColor = .white
                genreLabel.textColor = .systemBlue
            } else {
                self.backgroundColor = .systemBlue
                genreLabel.textColor = .white
            }
        }
    }
}
