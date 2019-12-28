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
    func onMovieCellSelected(movie:MovieModel)
}

class MoviesCollectionViewDriver : NSObject {
    
    let collectionView: UICollectionView
    let disposeBag = DisposeBag()
    weak var delegate: MoviesCollectionProtocol?
    let refreshControl: UIRefreshControl = UIRefreshControl()
    var page = 1
    
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
        self.collectionView.refreshControl = self.refreshControl
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func bind() {
        self.viewModel.movies.asObservable()
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: {[weak self] (models) in
                guard let self = self else {return}
                if self.refreshControl.isRefreshing { self.refreshControl.endRefreshing() }
                self.collectionView.reloadData()
                
            }).disposed(by: disposeBag)
        
        self.viewModel.page.asObservable()
            .subscribe(onNext: {[weak self] (v) in
                self?.page = v
            }).disposed(by: disposeBag)
    }
    
    @objc func refresh() {
        self.viewModel.get(page: 1)
    }
    
    func reload(){
        self.viewModel.get(page: page)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource -
extension MoviesCollectionViewDriver : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {
    
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.viewModel.reloadIfNeeded(fromIndex: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        cell.configureWith(movie: self.viewModel.movies.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.onMovieCellSelected(movie: self.viewModel.movies.value[indexPath.row])
    }
    
}
