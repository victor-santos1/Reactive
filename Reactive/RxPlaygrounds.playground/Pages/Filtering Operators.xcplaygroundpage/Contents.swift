import Foundation
import RxSwift
import RxCocoa

let strikes = PublishSubject<String>()
var elements = PublishSubject<String>()

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

example(of: "filter") {
 
    Observable.of(1, 2, 3, 4, 5, 6)
        .filter( { $0.isMultiple(of: 2) })
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: bag)
}

example(of: "skip") {
    
    Observable.of("A", "B", "C", "D", "E", "F")
        .skip(1) // -> pula a quantidade de numeros. Eventos começam a partir do numero atribuido. print (B, C...)
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: bag)
}

example(of: "skipWhile") {
    
    Observable.of(2, 2, 3, 4, 4, 5, 6)  // (ignora) skip até que algo seja != ao predicado...
        .skipWhile({ $0.isMultiple(of: 2) }) // -> apenas skip até que algo não seja ignorado e, a partir desse ponto, deixa todo o resto passar.
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: bag)
}

example(of: "skipUntil") {
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()
    
    subject
        .skipUntil(trigger)
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: bag)
    
    trigger.onNext("x")
   // trigger.onNext("x")
   // trigger.onNext("x")
   // trigger.onNext("x")
    subject.onNext("A")
    subject.onNext("B")
    subject.onNext("C")
    subject.onNext("D")
    subject.onNext("E")
    
    trigger.onNext("x")
}

