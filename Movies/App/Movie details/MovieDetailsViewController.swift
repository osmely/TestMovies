//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Osmely Fernandez on 12/27/19.
//  Copyright © 2019 Osmely Fernandez. All rights reserved.
//

import UIKit
import RxSwift

class MovieDetailsViewController: ViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var movie:MovieModel!
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        GetMovieDetailsRequest(id: self.movie.id).execute { (result) in
            do {
                let movieDetails = try result.get()
                self.presentDetails(width: movieDetails)
            } catch {
                
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
    }
    
    private func configure() {
        if let url = URL(string: movie.posterPath(width: 500) ?? "") {
            self.movieImageView.yy_setImage(with: url, options: .setImageWithFadeAnimation)
        } else {
            self.movieImageView.image = nil
        }
        
        scrollView.rx.contentOffset
            .asDriver()
            .drive(onNext: {[weak self] (offset) in
                guard let self = self else { return }
                self.topConstraint.constant = min(offset.y, 0)
                self.bottomConstraint.constant = min(offset.y, 0)
                self.movieImageView.layoutIfNeeded()
            }).disposed(by: disposeBag)
        
        presentDetails(width: self.movie)
    }
    
    
    func presentDetails(width model: MovieModel) {
        let formattedString = NSMutableAttributedString()
        formattedString
            .boldLine(movie.title ?? movie.original_title, size: 36)
        
        var genres = "-"
        if let details = model as? MovieDetailsModel {
            formattedString
                .normalLine("")
                .boldLine("Duración:")
                .normalLine("\(details.runtime ?? 0) min")
            
            genres = details.genres?
                .map({$0.name})
                .joined(separator: ", ") ?? "-"
        }
        
        var release_date = "-"
        if let date = movie.date {
            formatter.locale = Locale(identifier: "es")
            formatter.dateFormat = "d-MMM-yyyy"
            release_date = formatter.string(from: date)
        }
        
        formattedString
            .normalLine("")
            .boldLine("Fecha de estreno:")
            .normalLine(release_date)
            
            .normalLine("")
            .boldLine("Calificatión:")
            .normalLine("\(model.vote_average ?? 0)")
            
            .normalLine("")
            .boldLine("Géneros:")
            .normalLine(genres)
            
            .normalLine("")
            .boldLine("Descripción:")
            .normalLine(model.overview)
        
        movieDescriptionLabel.attributedText = formattedString
        
    }
}
