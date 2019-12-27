//
//  MoviesCollectionViewDriver.swift
//  Movies
//
//  Created by Osmely Fernandez on 12/27/19.
//  Copyright © 2019 Osmely Fernandez. All rights reserved.
//

import Foundation
import UIKit

protocol MoviesCollectionProtocol : class {
    func onMovieCellSelected()
}

class MoviesCollectionViewDriver : NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let collectionView: UICollectionView
    weak var delegate: MoviesCollectionProtocol?
    
    init(_ collection: UICollectionView) {
        self.collectionView = collection
        super.init()
        
        self.collectionView
            .register(UINib(nibName: String(describing: MovieCollectionViewCell.self), bundle: nil),
                      forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.onMovieCellSelected()
    }
    
    
    func reload(){
        
        self.collectionView.reloadData()
    }
}
