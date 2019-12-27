//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Osmely Fernandez on 12/27/19.
//  Copyright © 2019 Osmely Fernandez. All rights reserved.
//

import UIKit
import YYWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureWith(movie: MovieModel) {
    
        if let url = URL(string: movie.picture ?? "") {
            self.movieImageView.yy_setImage(with: url, options: .setImageWithFadeAnimation)
        } else {
            self.movieImageView.image = nil
        }
    }

}
