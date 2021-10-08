//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

enum MyError: Error {
    case anError
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, (event.element ?? event.error) ?? event)
}
let subject = BehaviorSubject(value: "valor inicial")
let disposeBag = DisposeBag()

subject //inscrito
    .subscribe {
        print(label: "1)", event: $0)
        
    }.disposed(by: disposeBag)


subject //inscrito
    .subscribe {
        print(label: "2)", event: $0)
    }.disposed(by: disposeBag)


subject.onNext("Novo valor") // Valor a ser mostrado em todos os inscritos

subject.onError(MyError.anError) //atribuindo error

subject //inscrito
    .subscribe {
        print(label: "3)", event: $0)
    }.disposed(by: disposeBag)


//após error subject não "emite novo valor" | É descartado
subject//inscrito
    .subscribe {
        print(label: "4)", event: $0)
    }.disposed(by: disposeBag)

subject
    .onNext("AAH")


subject.subscribe(
    onNext: { _ in print("onNext") },
    onError: { _ in print("Error") },
    onCompleted: { print("onCompleted") },
    onDisposed: { print("Descartado") })

