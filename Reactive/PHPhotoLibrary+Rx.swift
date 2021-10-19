//
//  PHPhotoLibrary+Rx.swift
//  Reactive
//
//  Created by Victor on 19/10/21.
//

import Foundation
import Photos
import RxSwift

extension PHPhotoLibrary {
    static var authorized: Observable<Bool> {
        return Observable.create { observer in
            
            DispatchQueue.main.async {
                if authorizationStatus() == .authorized {
                    observer.onNext(true)
                    observer.onCompleted()
                } else {
                    observer.onNext(false)
                    requestAuthorization {
                        newStatus in
                        observer.onNext(newStatus == .authorized)
                        observer.onCompleted()
                    }
                }
            }
            return Disposables.create()
        }
    }
}
