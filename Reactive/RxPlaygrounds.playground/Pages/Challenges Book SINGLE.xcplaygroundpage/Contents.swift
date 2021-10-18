//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

enum Errors: Error {
    case someError
}

let bag = DisposeBag()
func save(_ number: Int) -> Single<String> {
    return Single<String>.create { single -> Disposable in
       
        if number == 1 {
        
            single(.success("Ok"))
        } else if number == 2 {
            single(.error(Errors.someError))
        }
        
        return Disposables.create()
    }
}

let resut = save(1).subscribe { event in
    print(event)
}
