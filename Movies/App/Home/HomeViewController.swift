//
//  HomeViewController.swift
//  Movies
//
//  Created by Osmely Fernandez on 12/27/19.
//  Copyright © 2019 Osmely Fernandez. All rights reserved.
//

import UIKit

class HomeViewController: ViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate lazy var driver:MoviesCollectionViewDriver = {
        let d = MoviesCollectionViewDriver(collectionView)
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
