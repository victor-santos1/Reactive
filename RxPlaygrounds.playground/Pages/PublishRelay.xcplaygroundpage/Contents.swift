import Foundation
import RxSwift
import RxCocoa

enum MyError: Error {
    case anError
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, (event.element ?? event.error) ?? event)
}

let relay = PublishRelay<String>()
let bag = DisposeBag()

relay.accept("Toque toque, alguém em casa?")

relay
    .subscribe(onNext: {
        print($0)
    }).disposed(by: bag)

relay.accept("1")

///Não aceita erro ou completo
//relay.accept(MyError.anError)
//relay.onCompleted()

