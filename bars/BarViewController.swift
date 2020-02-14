//
//  BarViewController.swift
//  Bar
//
//  Created by Eduarda on 29/01/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit

//Importa uma forma de se comunicar com o sistema, seria como um print, ele oferece mais controle sobre quando as mendagens serão exibidas e salvas
import os.log

/*Classe designada para o cadastro de bares, toda parte de controller da view de cadastro de
 *bares é feita nessa classe, toda as declações da view também, ela também é responsavél em*
 *fazer as edições dos bares
 */
class BarViewController : UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {
    
    //MARK: Propriedades
    var bar : Bar?
   
    @IBOutlet weak var textNome: UITextField!
    @IBOutlet weak var textTelefone: UITextField!
    @IBOutlet weak var btnSalvar: UIBarButtonItem!
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var rua: UITextField!
    @IBOutlet weak var bairro: UITextField!
    @IBOutlet weak var numeroCasa: UITextField!
    @IBOutlet weak var estrelas: RatingBar!
    
    //MARK: Action
    //Botão cancelar, para voltar a view anterior
    @IBAction func btnCancelar(_ sender: UIBarButtonItem) {
        
        let isPresentingInAddBarMode = presentingViewController is UINavigationController
        
            if isPresentingInAddBarMode {
                dismiss(animated: true, completion: nil)
        }
            else if let owningNavigationController = navigationController {
                owningNavigationController.popViewController(animated: true)
        }
            else {
                fatalError("O BarViewControlle não foi apresentado a um controlador de navegação")
        }
        
    }
    //Botão para salvar edições ou cadastro de novo bar
    @IBAction func btnSalva(_ sender: Any) {
        print("Nome do bar "+textNome.text!)
    }
    
    //Abriando a galeria e camera
   @IBAction func abriGaleria(_ sender: Any) {
        EscolherImage().selecionadorImagem(self){
            //Aqui temos a nossa imagem
            imagem in
            self.imagem.image = imagem
        }
    }
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        textNome.delegate = self;
        textTelefone.delegate = self;
        longitude.delegate = self;
        latitude.delegate = self
        rua.delegate = self
        bairro.delegate = self
        numeroCasa.delegate =  self
        
        /*Se o bar já for existente, irá carregar as informações do bar nos campos de texto
         apartir deste if*/
        if let bar = bar {
            navigationItem.title = bar.nome
            textNome.text = bar.nome
            imagem.image = bar.foto
            estrelas.rating = bar.classifica
            latitude.text = String(bar.lati)
            longitude.text = String(bar.long)
            bairro.text = bar.bairro
            numeroCasa.text = String(bar.numeroCasa)
            textTelefone.text = bar.telefone
            rua.text = bar.rua
            
        }
        
        updatebtnSalvarStates()
    }
    //MARK: Funções
    //Metodo para desabilitar o botão salvar caso os campos estiverem vazios
    private func updatebtnSalvarStates() {
        let text = textNome.text ?? ""
        btnSalvar.isEnabled = !text.isEmpty
    }
    
    //Metodo para desabilitar o botão salvar enquanto o usuario estiver digitando
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        btnSalvar.isEnabled = false
        return true

    }
    //Está função irá salvando as informações que estão sendo digitada no Model, para facilitar
    //quando o usuario terminar de preencher todos os campos e salvar o bar
    func textFieldDidEndEditing(_ textField: UITextField) {
        updatebtnSalvarStates()
        navigationItem.title = textField.text
        
    }
    
    //Metodo que voce configura a viewController presente
    override func prepare(for segue: UIStoryboardSegue, sender : (Any)?) {
        super.prepare(for : segue, sender : sender )
        //Configura o destino da viewController
        // "===" ultilizado para verificar se o botão sender e o btnSalvar tem a mesma saída
        guard let button = sender as? UIBarButtonItem, button === btnSalvar
            else {
                os_log("O botão salvar não foi precionado, cancelar", log: OSLog.default, type: .debug)
                return
        }
        //Recebendo todas as informações digitadas pelo usuario e fazendo as converções
        //necessarias para salvar o bar 
        let lati = (latitude.text! as NSString).floatValue
        let long = (longitude.text! as NSString).floatValue
        let nome = textNome.text ?? ""
        let foto = imagem.image
        let classifica = estrelas.rating
        let telefone = textTelefone.text
        let nCasa : Int? = Int((numeroCasa.text! as NSString) as String)
        let bairro0 = bairro.text
        let rua0 = rua.text
        
        bar = Bar(nome: nome, telefone: telefone!, long: long, lati: lati, foto: foto, classifica: classifica, numeroCasa: nCasa!, rua: rua0!, bairro: bairro0!)
    
    }

}
//MARK: Classe EscolherImagem

//Classe para acessar a galeria e camera, selecionando e mostrando a imagem na tela
class EscolherImage : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Propriedades da classe EscolherImagem
    
    //Instancia o controle do sistema de imagens
    var selecionador = UIImagePickerController();
    
    //Cria um alerta
    var alerta = UIAlertController (title: "escolha uma opção", message: nil, preferredStyle: .actionSheet)
    
    //Cria um UIViewController
    var viewController : UIViewController?
    
    //Cria um callback @escaping
    var retornoSelecionador : ((UIImage) -> ())?;
    
    //MARK: Função Principal da classe EscolherImagem
    func selecionadorImagem(_ viewController : UIViewController, _ retorno: @escaping ((UIImage) -> ())) {
        
        /*Declara o callback dessa função como sendo a variavel externa pickImageCallBack,
         * servindo como retorno, pois o retono apos a escolha da imagem está em outro metodo
         */
        
        retornoSelecionador = retorno;
        
        /*Declaramos o View Conroller para transições de tela*/
        
        self.viewController = viewController;
        
        //Menu de interação para acessar a camera ou a galeria
        
        //Cada ação é responsavel por chamar o metodo que o usuario pretende ultilizar
        
        //Se o usuario clicar na galeria irá abrir a galeria
        let galeria = UIAlertAction(title: "Galeria", style: .default) {
            UIAlertAction in
            self.abrirGaleria(viewController);
        }
        //Se o usuario clicar em camera irá abrir a camera
        let camera = UIAlertAction(title: "Camera", style: .default) {
            UIAlertAction in
            self.abrirCamera(viewController);
        }
        //Se o usuario clicar em cancelar, ele saira do menu e voltara a tela de cadastro
        let cancelar = UIAlertAction(title: "Cancela", style: .default) {
            UIAlertAction in
        }
       /*Declara que o novo delegate do selecionador são os métodos
        ImagePickerControllerDidCancel e o imagePickerController que serão criados abaixo*/
        selecionador.delegate = self
        
            //Adicionando ação ao alerta
            alerta.addAction(galeria)
            alerta.addAction(cancelar)
            alerta.addAction(camera);
        
        //Exibe alerta na tela
        alerta.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alerta, animated: true, completion: nil)
    }
    //Função que irá abrir a camera do celular
    func abrirCamera(_ viewController : UIViewController) {
        
        //Desfaz o alerta de seleção gerado anteriormente
        alerta.dismiss(animated: true, completion: nil)
        //Verificação se tem premissão a camera
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            //Define o tipo que queremos selecionar como a camera
            selecionador.sourceType = .camera
            //Abrir a camera
            viewController.present(selecionador, animated: true, completion: nil)
            
        }else{
            //Se o usuario nao possuir camera irá aparecer este alerta, se tiver ultilizando um simulador por exmeplo
            let alerta = UIAlertController(title: "Alerta", message: "Voce não tem camera", preferredStyle: .actionSheet)
            //Cria outra ação
            let cancelar = UIAlertAction(title: "Cancela", style: .cancel) {
                UIAlertAction in
        }
            //Mostra alerta
            alerta.addAction(cancelar);
            viewController.present(alerta, animated: true, completion: nil)
            
        }
    }
    //Função que irá abrir a galeria do celular
    func abrirGaleria(_ viewController : UIViewController){
        //Desfaz o alerta gerado
        alerta.dismiss(animated: true, completion: nil)
        
        //Por default o tipo de abertura do selecionador em cena é a galeria
        selecionador.sourceType = .photoLibrary
    
        //Abre tela galeria
        viewController.present(selecionador, animated: true, completion: nil)
        
    }
    //Metodo que é chamado se a pessoal cancelar a ação
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Desfaz a tela de galeria que foi gerada
        picker.dismiss(animated: true, completion: nil)
    }
        //Metodo chamado apos a escolha de Imagem
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        //Desfaz as tela que foram geradas, no caso a tela de camera e galeria
        picker.dismiss(animated: true, completion: nil)
            
        //Verifica se o arquivo é mesmo uma imagem, passando uma mensagem caso nao seja uma imagem
        guard let image = info[. originalImage] as? UIImage else {
            fatalError("espera uma imagem, mas foi pego o seguinte dado: \(info)")
        }
    //Retorna o callback da função SelecionadorImagem
    retornoSelecionador?(image)
    }
    
    
}


