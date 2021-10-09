import Foundation
import RxSwift
import RxCocoa

enum MyError: Error {
    case anError
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, (event.element ?? event.error) ?? event)
}
    //numeros de eventos para lançar quando houver um novo inscrito
      //definindo quantidade a ser armazenada em cache |
      //                                               v
let subject = ReplaySubject<String>.create(bufferSize: 3)
let bag = DisposeBag()

//Adicionado valores (eventos) de acordo com a quantidade em buffrSize
subject.onNext("primeiro valor")
subject.onNext("segundo valor")
subject.onNext("terceiro valor")

subject//inscrito
    .subscribe {
    print(label: "1)", event: $0)
    }.disposed(by: bag)

subject
    .subscribe {
        print(label: "2)", event: $0)
    }.disposed(by: bag)

subject.onError(MyError.anError)
subject.dispose()

subject
    .subscribe {
        print(label: "3)", event: $0)
    }.disposed(by: bag)


