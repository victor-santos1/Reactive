//
//  WeatherViewModel.swift
//  Reactive
//
//  Created by Victor on 04/10/21.
//

import Foundation
import RxSwift
import RxCocoa

class WeatherViewModel {
        var text = Observable<String>.just("")
        private let disposeBag = DisposeBag()

}
//var items = Observable.just([
//    Product(imageName: "house", title: "House"),
//    Product(imageName: "gear", title: "Settings"),
//    Product(imageName: "persona.circle", title: "Profile"),
//    Product(imageName: "airplane", title: "Fligths"),
//    Product(imageName: "bell", title: "Activity")
//])
