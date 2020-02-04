//
//  BarTableViewController.swift
//  bars
//
//  Created by Jonathan on 04/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit

class BarTableViewController: UITableViewController {
    
    var Bares = [Bar]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    /* Metodos
     * func Carrega dados ela é responsavel no carregamento de dados da classe bar para a tabelaBares
     */
    
    
    private func CarregarDados() {
     
        let foto1 = UIImage(named: "Image-1")
        let foto2 = UIImage(named: "Image-2")
        let foto3 = UIImage(named: "Image")
        
        guard let Image-1 = Bar.init(nome: "Bar do Juka", telefone: "3323-3325", long: 15, lati: 15, foto: foto1, classifica: 5, numeroCasa: 10, rua: "São Paulo", bairro: "Itoupava")
            else {
                fatalError("Algo está errado!!")
        }
        
                
    }
   


}
