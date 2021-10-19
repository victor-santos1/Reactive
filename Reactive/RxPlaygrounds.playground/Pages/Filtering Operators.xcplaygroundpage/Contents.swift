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
    
    //trigger.onNext("Evento")
    subject.onNext("A")
    subject.onNext("B")
    trigger.onNext("Evento") // Só vai emitir a eventos a partir desse
    subject.onNext("C")
    subject.onNext("D")
    subject.onNext("E")
}

example(of: "take") {
    
    Observable.of(1, 2, 3, 4, 5, 6)
        .take(3) // -> pega os n (3) primeiros elementos e ignora o restante
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: bag)
}

example(of: "takeWhile") {
    
    Observable.of(2, 2, 4, 6, 6, 5, 9) // -> A partir do 5 e abaixo do index 5 ele ignora
        .enumerated()
        .takeWhile { index, number in
            number.isMultiple(of: 2) && index < 5
        }
        .map(\.element)
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: bag)
}

example(of: "takeUntil") {
    
    Observable.of(1, 2, 3, 4, 5, 6)
        .takeUntil(.exclusive) { $0.isMultiple(of: 4) } // -> para de pegar os elementos até satisfazer o predicado "inclusive" o predicado
        // Ou para de pegar os elementos até antes de satisfazer o predicado "exclusive" o predicado
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: bag)
}

example(of: "takeUntil - Trigger") {
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()
    
    subject
        .takeUntil(trigger)
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: bag)
    
    subject.onNext("1")
    subject.onNext("2")
    trigger.onNext("X") // -> Emitir eventos até encontrar um "gatilho" - fazendo ignorar o restante
    subject.onNext("4")
    subject.onNext("5")
}
example(of: "distinctUntilChanged") {
    
    Observable.of("A", "A", "B", "B", "A", "C", "C")
        
        .distinctUntilChanged() // -> ignorado até ser alterado. Se recusa a emitir elementos iguais (sequencialmente)
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: bag)
}

example(of: "distinctUntilChanged") {
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    
    Observable<NSNumber>.of(10, 110, 20, 200, 210, 310)
        .distinctUntilChanged { a, b in
            guard
                let aWords = formatter
                    .string(from: a)?
                    .components(separatedBy: " "),
                let bWords = formatter
                    .string(from: b)?
                    .components(separatedBy: " ")
            else {
                return false
            }
            var containsMatch = false
            for aWord in aWords where bWords.contains(aWord) {
                containsMatch = true
                break
            }
            return containsMatch
        }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: bag)
}

example(of: "Rx na pratica teste") {
    var start = 0
    let numbers = Observable<Int>.create { observer in
        let start = getStartNumber()
        observer.onNext(start)
        observer.onNext(start+1)
        observer.onNext(start+2)
        observer.onCompleted()
        return Disposables.create()
    }
   
    func getStartNumber() -> Int {
        start += 1
        return start
    }
    
    numbers
        .subscribe(
            onNext: {
                el in
                print("element [\(el)]")
            }, onCompleted: {
                print("-------------------")
            })
    
    numbers
      .subscribe(
        onNext: { el in
          print("element [\(el)]")
        },
        onCompleted: {
          print("-------------------")
        })
}
