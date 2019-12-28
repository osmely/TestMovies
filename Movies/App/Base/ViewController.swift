//
//  ViewController.swift
//  Movies
//
//  Created by Osmely Fernandez on 12/27/19.
//  Copyright © 2019 Osmely Fernandez. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    var preferrsNavigationBarHidden: Bool {
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.setNavigationBarHidden(preferrsNavigationBarHidden, animated: animated)
        
        if let title = self.title {
            self.labelToNavigationItem(with: title)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func labelToNavigationItem(with text:String){
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = text
        self.navigationItem.titleView = label
    }
}





