import Foundation
import RxSwift
import RxCocoa

let bag = DisposeBag()

public func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action()
}
example(of: "Default") {
    Observable.of("A", "B", "C")
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: bag)
}

example(of: "toArray") {
    Observable.of("A", "B", "C")
        .toArray() //-> Trasforma todos os elementos em um array contendo todos os elementos (por de baixo ele é um Single e retorna success(array))
        .subscribe(onSuccess: {
            print($0)
        })
        .disposed(by: bag)
}

example(of: "map") {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency //.spellOut
    formatter.locale = Locale.init(identifier: "pt-BR")
    Observable<Int>.of(500, 45, 13, 7)
        .map {
            formatter.string(for: $0) ?? ""
        }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: bag)
}

example(of: "enumerated and map") {
    Observable.of(1, 2, 3, 4, 5, 6)
        .enumerated()
        .map { index, number in
            index > 2 ? number * 2 : number
        }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: bag)
}

example(of: "compactMap") {
    
    Observable.of("To", "be", nil, "or", "to", "be", nil)
        .compactMap { $0 }
        .toArray()
        .map { $0.joined(separator: " ") }
        .subscribe(onSuccess: {
            print($0)
        })
        .disposed(by: bag)
}

struct Student {
    let score: BehaviorSubject<Int>
}

example(of: "flatMap") {
    let victor = Student(score: BehaviorSubject(value: 80))
    let laura = Student(score: BehaviorSubject(value: 90))
    
    let student = PublishSubject<Student>()
    student
        .flatMap { $0.score }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: bag)
    
    student.onNext(laura)
    student.onNext(victor)
    
    laura.score.onNext(85)
}
