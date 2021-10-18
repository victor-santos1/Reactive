import Foundation
import RxSwift
import RxCocoa

enum MyError: Error {
    case anError
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, (event.element ?? event.error) ?? event)
}

let relay = BehaviorRelay(value: "Valor inicial")
let disposeBag = DisposeBag()


relay.accept("Novo valor")

relay
    .subscribe {
        print(label: "1)", event: $0)
    }
    .disposed(by: disposeBag)

relay.accept("1")

relay
    .subscribe {
        print(label: "2)", event: $0)
    }.disposed(by: disposeBag)

relay.accept("2")

//valor puro
print(relay.value)



