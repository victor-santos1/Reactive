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
    
    let lista = PublishSubject<[Aluno]> ()
    
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureTableView()
        
        lista.onNext(listaAlunos)
        lista.onCompleted()
    }
    
    func configureTableView() {
        lista.bind(to: tableView.rx.items(cellIdentifier: "cell")) {
            algo, items, cell in
            cell.textLabel?.text = items.nome
        }.disposed(by: bag)
        
       // tableView.rx
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
           //let secondVC = SecondViewController
            
        }
    }


        let listaAlunos = [
            Aluno(nome: "Victor", dataNascimento: "03/10/1997", notas: [7,6,5,8], cpf: "459.041.368-03"),
            Aluno(nome: "Leo", dataNascimento: "30/01/2000", notas: [3,4,4,2], cpf: "535.723.570-80"),
            Aluno(nome: "Mônica", dataNascimento: "06/04/1999", notas: [5,6,7,8], cpf: "114.029.720-16"),
            Aluno(nome: "Gabriel", dataNascimento: "18/06/2007", notas: [3,5,6,4], cpf: "545.522.368-03"),
            Aluno(nome: "Fernando", dataNascimento: "23/11/2008", notas: [8,7,9,10], cpf: "963.246.453-03"),
            Aluno(nome: "Aline", dataNascimento: "04/12/1990", notas: [5,7,5,8], cpf: "401.616.500-82"),
            Aluno(nome: "Jessica", dataNascimento: "17/02/2004", notas: [9,6,9,5], cpf: "343.456.232-02"),
            Aluno(nome: "Gustavo", dataNascimento: "08/05/2005", notas: [5,3,8,6], cpf: "201.245.540-52")
        ]
}




//MARK: - Classe Aluno Ex - 1
class Aluno {
    let nome: String
    let dataNascimento: String
    let notas: [Double?]
    let cpf: String
    
    private var anoAluno: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        return dateFormatter.date(from: dataNascimento)!
    }
    
    init(nome: String, dataNascimento: String, notas: [Double], cpf: String) {
        self.nome = nome
        self.dataNascimento = dataNascimento
        self.notas = notas
        self.cpf = cpf
    }
    
    func toString() -> String {
        "Aluno \(nome) tem \(dataNascimento) anos"
    }
    
    func isApproved() -> Bool {
        var aprovado: Bool = false
        let resultNota = mediaNotas()
        resultNota < 6 ? (aprovado = false) : (aprovado = true)
        return aprovado
    }
    
    func maiorIdade() -> Bool {
        let nascimentoAluno = Calendar.current.dateComponents([.year], from: anoAluno)
        let hoje = Calendar.current.dateComponents([.year], from: Date())
        guard let anoNascimentoAluno = nascimentoAluno.year else { return false }
        guard let anoAtual = hoje.year else { return false }
       return anoNascimentoAluno + 18 <= anoAtual
    }
    
    func mediaNotas() -> Double {
        let notaFinal = notas.reduce(0) { $0 + $1!/4 }
        return notaFinal
    }
}
