//
//  NetworkRequestsManager+rx.swift
//  Movies
//
//  Created by Osmely Fernandez on 12/27/19.
//  Copyright © 2019 Osmely Fernandez. All rights reserved.
//

import Foundation
import RxSwift
import EasyNetRequest

extension EasyNetRequest {
    func rx_execute() -> Observable<EasyNetResponseType> {
        return Observable<EasyNetResponseType>.create({ (observer) -> Disposable in
            
            self.execute { (result) in
                do {
                    let response = try result.get()
                    observer.onNext(response)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            
            return Disposables.create{}
        })
    }
    
    func single() -> Single<EasyNetResponseType> {
        return Single.create(subscribe: { (single) -> Disposable in
            
            self.execute { (result) in
                do {
                    let response = try result.get()
                    single(.success(response))
                } catch {
                    single(.error(error))
                }
            }
            
            return Disposables.create {}
        })
        
    }
}


