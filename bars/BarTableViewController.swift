//
//  BarTableViewController.swift
//  Bares
//
//  Created by Eduarda on 04/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import os.log

/*Nesta classe temos todos as manipulações feitas na view de tabela bares, também será
 * responsável em caregar todos os dados que serão mostrados pelas views
 */
class BarTableViewController: UITableViewController {
    
    //MARK: Propriedades
    var bares = [Bar]()
 
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //Criando um botão automaticamente, ultilizado para deletar
        navigationItem.leftBarButtonItem = editButtonItem
        //Carrega dados dos arquivos Url, se ja tiver bares salvos
        if let saveBares = loadBares() {
        bares += saveBares
            
            
        }
        //Se retorna nil, ele apenas carrega os bares ja cadastrados
        else {
            //Chamando o metodo para Carregar os dados
            CarregarDados()
        
        }
    }
   
    //MARK: Action
    
    //AS? está converte para tentar fazer dowcast do controlador, se nao for possivel fazer conversao vai retornar nil, também se tornado false sendo impossivel executar a if instrução
    @IBAction func unwindToBarList(sender : UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? BarViewController, let bar = sourceViewController.bar {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //Atualizando bar existente
                bares[selectedIndexPath.row] = bar
                //Recarregando minha tabela mudando o index
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                //Adicionando novo Bar
                let newIndexPath = IndexPath(row: bares.count, section: 0)
                
                bares.append(bar)
                //Inserindo na tabela, criando novo index
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                
            }
            saveBares()
        }
    }
    //MARK: Private Funções
    
    /*Função responsavél quando o usuario for salvar o bar, cada bar será salvo no ArchiveURL,
     * uma persistencia de dados, que quando o usuario sair do aplicativo ainda estará salvo os
     * bares que ele cadastro
     */
    private func saveBares() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(bares, toFile: Bar.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Bares foram salvos com sucesso.", log: OSLog.default, type: .debug)
        } else {
            os_log ("falha ao salvar os bares.....", log: OSLog.default, type: .debug)
            
        }
    }
    //Função responsavel por carregar os bares que estiverem salvos no ArchiveURL
    private func loadBares() -> [Bar]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile : Bar.ArchiveURL.path) as? [Bar]
        
    }
  
     /* Responsavel no carregamento de dados da classe bar para a tabelaBares, aqui posso deixar
     * bares pré-cadastrados manualmente
     */
    private func CarregarDados() {
     
        let foto1 = UIImage(named: "Image1")
        let foto2 = UIImage(named: "Image2")
        let foto3 = UIImage(named: "Image3")
        
        guard let Image1 = Bar.init(nome: "Bar do Juka", telefone: "3323-3325", long: -49.070986, lati: -26.915024, foto: foto1, classifica: 5, numeroCasa: 10, rua: "São Paulo", bairro: "Itoupava")
            else {
                fatalError("Algo está errado!!")
        }
        guard let Image2 = Bar.init(nome: "Bar do Tijolao", telefone: "33325569", long: -49.070781, lati: -26.913993, foto: foto2, classifica: 3, numeroCasa: 8, rua: "Rua São Jose", bairro: "São Luis")
            else {
                fatalError("Algo está errado!!")
        }
        guard let Image3 = Bar.init(nome: "Bar do Julio", telefone: "33251415", long: -49.069460, lati: -26.915129, foto: foto3, classifica: 2, numeroCasa: 2, rua: "São Jose", bairro: "Nova Esperança")
            else {
                fatalError("Algo está errado!!")
        }
        bares += [Image1, Image2, Image3]
    }
    
    //MARK: Override Funções
    
    //Metodo para exibir uma seção em sua exibição de tabela 
    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }
    
    //Retorna o numero de lihas da tabela
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return bares.count
    }
    //Configurando a Tabela
    //Mostra todos os atributos de cada bar
    //Nesse caso está mostrando a foto, nome do bar e a classificação
    //return cell (Celulas)
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TabelaBares"
        
        //As? para que a celula não receba algo que nao tenha na tabelaBares.
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TabelaBares
        
        //Pegando a posição na tabela, para cetar as informações na celula de cada bar.
        let bar = bares[indexPath.row]
        
        cell?.NomeBar.text = bar.nome
        cell?.FtBar.image = bar.foto
        cell?.Classifcacao.rating = bar.classifica
        cell?.backgroundColor = UIColor.yellow
        
        return cell!
        }
    //Navegation
    
    //Preparando para iniciar uma novo segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        super.prepare(for: segue, sender: sender)
        //Aqui fazemos uma verificação apartir da segue selecionada.
        switch(segue.identifier ?? "") {
            case "addItem" :
                os_log ("Adiciona novo Bar.", log: OSLog.default, type: .debug)
            
            case "showDetail" :
                guard let barDetailViewController = segue.destination as? BarViewController
                    else {
                        fatalError("Unexpected destination: \(segue.destination)")
                    
                }
                guard let selectedBarCell = sender as? TabelaBares
                    else {
                        fatalError("Unexpected sender: \(String(describing: sender))")
                }
            
                guard let indexPath = tableView.indexPath (for: selectedBarCell)
                    else {
                        fatalError("O Bar selecionado não está disponivel na tabela")
                    }
            let selectedBar = bares[indexPath.row]
                barDetailViewController.bar = selectedBar
        default : break
           // fatalError("Segue Indetificado: \(String(describing: segue.identifier))")
        }
    }
   
    //Override de suporte para edição da tabela
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Deletar o bar a partir de sua posição
            bares.remove(at: indexPath.row)
            
            //Salvando
            saveBares()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            //Cria uma nova instancia
        }
    }
    //Override suporte a edição condicional da exibição de tabela
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Retorno falso se voce não deseja que o item clicado seja editado
        return true
    }
    
}


