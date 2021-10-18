//: [Previous](@previous)

import Foundation
import RxSwift
import RxCocoa

//Criando ou definido um PublishSubject || publicador
let subject = PublishSubject<String>()

//atribuindo ao "publicador" || valor ao publicador
subject.on(.next("Texto definido antes de ter ouvintes"))

//definindo acao a partir do que é "listening" || pronto para receber o valor de subject (publicador)
let subscription = subject //ouvinte
    .subscribe(onNext: { string in
        print("1)", string)
    })

//publicando strings
subject.on(.next("Após inscrição"))
subject.onNext("Exemplo direto")

//Ouvinte | Inscrito - definindo ação para quando esse inscrito receber uma publicacão
let subscriptionTwo = subject.subscribe { event in
    print("2)", event.element ?? event)
}

//publicando string
subject.onNext("f")

//descartando o inscrito 1
subscription.dispose()

// publicando novamente algo | será ouvido apenas pelo segundo inscrito
subject.onNext("Novamente")

subject.onCompleted() // 2) completed

subject.onNext("Jailbreak para iOS 15") // não será ouvido
subscriptionTwo.dispose() // descartando esse ouvinte

let bolsaDeDescarte = DisposeBag()

subject.disposed(by: bolsaDeDescarte)
print("------------------------------")

subject
    .subscribe {
        print("3)", $0.element ?? $0)
    }
    .disposed(by: bolsaDeDescarte)

subject.onNext("?") //não será ouvido


//: [Next](@next)
