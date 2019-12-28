//
//  HomeViewController.swift
//  Movies
//
//  Created by Osmely Fernandez on 12/27/19.
//  Copyright © 2019 Osmely Fernandez. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class HomeViewController: ViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate lazy var driver:MoviesCollectionViewDriver = {
        let d = MoviesCollectionViewDriver(collectionView)
        d.viewModel = ViewModel()
        d.delegate = self
        return d
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Películas"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.driver.reload()
    }
    
}


// MARK: - MoviesCollectionProtocol -
extension HomeViewController : MoviesCollectionProtocol {
    func onMovieCellSelected() {
        let details = MovieDetailsViewController.instantiateFromNib()
        self.navigationController?.pushViewController(details, animated:true)
    }
    
}

// MARK: - ViewModel -
extension HomeViewController {
    
    class ViewModel {
        
        let movies = BehaviorRelay<[MovieModel]>(value:[])
        
        func get(page: Int) {
            GetMoviesRequest(page: page).execute { (result) in
                do {
                    let movies = try result.get()
                    self.movies.accept(movies.results)
                } catch {
                    self.movies.accept([])
                }
            }
        }
        
    }
    
}
