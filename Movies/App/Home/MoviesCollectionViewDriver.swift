//
//  MoviesCollectionViewDriver.swift
//  Movies
//
//  Created by Osmely Fernandez on 12/27/19.
//  Copyright © 2019 Osmely Fernandez. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


protocol MoviesCollectionProtocol : class {
    func onMovieCellSelected()
}

class MoviesCollectionViewDriver : NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let collectionView: UICollectionView
    let disposeBag = DisposeBag()
    weak var delegate: MoviesCollectionProtocol?
    
    var viewModel:HomeViewController.ViewModel! {
        didSet{
            self.bind()
        }
    }
    
    init(_ collection: UICollectionView) {
        self.collectionView = collection
        super.init()
        
        self.collectionView
            .register(UINib(nibName: String(describing: MovieCollectionViewCell.self), bundle: nil),
                      forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func bind() {
        
        self.viewModel.movies.asObservable()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { (models) in
                self.collectionView.reloadData()
            }).disposed(by: disposeBag)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else {return CGSize.zero}
        let space: CGFloat = flow.minimumInteritemSpacing +
            flow.sectionInset.left + flow.sectionInset.right
        let w = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: w, height: w * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.movies.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.configureWith(movie: self.viewModel.movies.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.onMovieCellSelected()
    }
    
    func reload(){
        self.viewModel.get(page: 1)
        
    }
}
