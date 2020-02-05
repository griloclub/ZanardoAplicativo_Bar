//
//  BarTableViewController.swift
//  bars
//
//  Created by Jonathan on 04/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit

class BarTableViewController: UITableViewController {
    
    var bares = [Bar]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Chamando o metodo para Carregar os dados
        CarregarDados()
        

    }
    
    /* Metodos
     * func Carrega dados ela é responsavel no carregamento de dados da classe bar para a tabelaBares
     */
    
    
    private func CarregarDados() {
     
        let foto1 = UIImage(named: "Image1")
        let foto2 = UIImage(named: "Image2")
        let foto3 = UIImage(named: "Image3")
        
        guard let Image1 = Bar.init(nome: "Bar do Juka", telefone: "3323-3325", long: 15, lati: 15, foto: foto1, classifica: 5, numeroCasa: 10, rua: "São Paulo", bairro: "Itoupava")
            else {
                fatalError("Algo está errado!!")
        }
        guard let Image2 = Bar.init(nome: "Bar do Tijolao", telefone: "33325569", long: 15, lati: 15, foto: foto2, classifica: 3, numeroCasa: 8, rua: "Rua São Jose", bairro: "São Luis")
            else {
                fatalError("Algo está errado!!")
        }
        guard let Image3 = Bar.init(nome: "Bar do Julio", telefone: "33251415", long: 16, lati: 16, foto: foto3, classifica: 2, numeroCasa: 2, rua: "São Jose", bairro: "Nova Esperança")
            else {
                fatalError("Algo está errado!!")
        }
        bares += [Image1, Image2, Image3]
    }
    
    //Metodo de uma seção para exibir a tabela
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    
    //Retorna o numero de lihas da tabela
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return bares.count
    }
    //Configurando a Tabela
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TabelaBares"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TabelaBares
        
        let bar = bares[indexPath.row]
        
        cell?.NomeBar.text = bar.nome
        cell?.FtBar.image = bar.foto
        cell?.Classifcacao.rating = bar.classifica
        
        return cell!
    }
    
    
}
