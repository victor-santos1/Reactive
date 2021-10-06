//
//  ViewController.swift
//  Reactive
//
//  Created by Victor on 27/09/21.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    let viewModel = WeatherViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func fetchData() {
        let request = AF.request("https://api.openweathermap.org/data/2.5/weather?q=guarulhos&appid=87cc5af3b2675ba6b83507c8f3e82d7e&lang=pt-br")
        
        request.responseJSON { response in
            do {
                let data = try JSONDecoder().decode(Json4Swift_Base.self, from: response.data!)
                print(data)
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
}
    
    
