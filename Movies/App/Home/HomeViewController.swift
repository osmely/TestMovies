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
    func onMovieCellSelected(movie:MovieModel) {
        let details = MovieDetailsViewController.instantiateFromNib()
        details.movie = movie
        self.navigationController?.pushViewController(details, animated:true)
    }
}

// MARK: - ViewModel -
extension HomeViewController {
    
    class ViewModel {
        let movies = BehaviorRelay<[MovieModel]>(value:[])
        let total_pages = BehaviorRelay<Int>(value:0)
        let page = BehaviorRelay<Int>(value:1)
        
        func get(page: Int) {
            GetMoviesRequest(page: page).execute {[weak self] (result) in
                guard let self = self else {return}
                
                do {
                    let movies = try result.get()
                    self.page.accept(movies.page)
                    self.total_pages.accept(movies.total_pages)

                    if let results = movies.results {
                        if movies.page == 1 {
                            self.movies.accept(results)
                        }else{
                            self.movies.accept(self.movies.value + results)
                        }
                    }
                } catch {
                    
                }
            }
        }
        
        func reloadIfNeeded(fromIndex:Int) {
            if page.value < self.total_pages.value && fromIndex == movies.value.count - 1 {
                self.get(page: page.value + 1)
            }
        }
    }
}
