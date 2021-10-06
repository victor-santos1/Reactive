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
    
        var url: String {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(text) searchText)&appid=87cc5af3b2675ba6b83507c8f3e82d7e&lang=pt-br"
        return url
    }
        private let disposeBag = DisposeBag()

}
//var items = Observable.just([
//    Product(imageName: "house", title: "House"),
//    Product(imageName: "gear", title: "Settings"),
//    Product(imageName: "persona.circle", title: "Profile"),
//    Product(imageName: "airplane", title: "Fligths"),
//    Product(imageName: "bell", title: "Activity")
//])
