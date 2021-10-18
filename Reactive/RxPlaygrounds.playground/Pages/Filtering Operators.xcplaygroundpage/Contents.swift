import Foundation
import RxSwift
import RxCocoa

let strikes = PublishSubject<String>()
let elements = PublishSubject<String>()

let bag = DisposeBag()
 
public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}


// MARK: - ignoreElements()
example(of: "ignoreElements") {

strikes
    .subscribe { _ in
        print("1º Inscrito")
    }.disposed(by: bag)


strikes
    .ignoreElements() // inscrito será ignorado até que receva um onCompleted
    .subscribe { _ in
    print("2º Inscrito")

}.disposed(by: bag)

strikes
    .subscribe { _ in
    print("3º Inscrito")

}.disposed(by: bag)

//Eventos emitidos |
//                 v
strikes.onNext("X") //-> não irá "enviará evento ao inscrito 2º (.ignoreElements)"
strikes.onCompleted()

}
// MARK: - elementAt()

example(of: "elementAt") {
 
    elements
        .elementAt(1) // seleciona evento na posição selecionada
        .subscribe(onNext: { element in
            print("1º Inscrito - \(element)") // Emite evento selecionado
        })
        .disposed(by: bag)

    elements.onNext("A") // 0
    elements.onNext("B") // 1
    elements.onNext("C") // 2
}
