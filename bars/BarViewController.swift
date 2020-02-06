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

class BarViewController : UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {
   
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
    
    //Botão cancelar os metodos de cadastra
    @IBAction func btnCancelar(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //Abriando a galeria e camera
   @IBAction func abriGaleria(_ sender: Any) {
        EscolherImage().selecionadorImagem(self){
            imagem in
            self.imagem.image = imagem
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        textNome.delegate = self;
        textTelefone.delegate = self;
        longitude.delegate = self;
        latitude.delegate = self
        rua.delegate = self
        bairro.delegate = self
        numeroCasa.delegate =  self
        
        updatebtnSalvarStates()
    }
    //Metodo para desabilitar o botão salvar enquanto o usuario estiver digitando
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        btnSalvar.isEnabled = false
        return true

    }
    
    //Metodo para desabilitar o botão salvar caso os campos estiverem vazios
    private func updatebtnSalvarStates() {
        let text = textNome.text ?? ""
        btnSalvar.isEnabled = !text.isEmpty
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updatebtnSalvarStates()
        navigationItem.title = textField.text
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var nomeCampo : String!
       switch textField {
            case textNome :
                nomeCampo = "Bar: "
                break
            case textTelefone :
                nomeCampo = "Telefone: "
                break
        
       default : break
        }
        var Message : String
        Message = nomeCampo + textField.text!
        print(Message)
        return true;
    }
    @IBAction func btnSalva(_ sender: Any) {
        print("Nome do bar "+textNome.text!)
    }
    //AS? está converte para tentar fazer dowcast do controlador, se nao for possivel fazer conversao vai retornar nil, também se tornado false sendo impossivel executar a if instrução
   
    
    
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
        let lati = (latitude.text! as NSString).floatValue
        let long = (longitude.text! as NSString).floatValue
        let nome = textNome.text ?? ""
        let foto = imagem.image
        let classifica = estrelas.rating
       // let lati = latitude.text
        //let long = longitude.text
        let telefone = textTelefone.text
        let nCasa : Int? = Int((numeroCasa.text! as NSString) as String)
       // let nCasa = numeroCasa.text
        let bairro0 = bairro.text
        let rua0 = rua.text
        
        bar = Bar(nome: nome, telefone: telefone!, long: long, lati: lati, foto: foto, classifica: classifica, numeroCasa: nCasa!, rua: rua0!, bairro: bairro0!)
    
    }
}

//classe para acessar a galeria e camera, selecionando e mostrando a imagem na tela

class EscolherImage : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var selecionador = UIImagePickerController();
    
    var alerta = UIAlertController (title: "escolha uma opção", message: nil, preferredStyle: .actionSheet)
    
    var viewController : UIViewController?
    
    var retornoSelecionador : ((UIImage) -> ())?;
    
    func selecionadorImagem(_ viewController : UIViewController, _ retorno: @escaping ((UIImage) -> ())) {
    
        retornoSelecionador = retorno;
        
        self.viewController = viewController;
        
        let galeria = UIAlertAction(title: "Galeria", style: .default) {
            UIAlertAction in
            self.abrirGaleria(viewController);
        }
        let cancelar = UIAlertAction(title: "Cancela", style: .default) {
            UIAlertAction in
        }
        let camera = UIAlertAction(title: "Camera", style: .default) {
            UIAlertAction in
            self.abrirCamera(viewController);
        }
        selecionador.delegate = self

            alerta.addAction(galeria)
            alerta.addAction(cancelar)
            alerta.addAction(camera);

        alerta.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alerta, animated: true, completion: nil)
    }
    
    func abrirCamera(_ viewController : UIViewController) {
        alerta.dismiss(animated: true, completion: nil)
        
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            
            selecionador.sourceType = .camera
            
            viewController.present(selecionador, animated: true, completion: nil)
            
        }else{
            let alerta = UIAlertController(title: "Alerta", message: "Voce não tem camera", preferredStyle: .actionSheet)
            let cancelar = UIAlertAction(title: "Cancela", style: .cancel) {
                UIAlertAction in
        }
            alerta.addAction(cancelar);
            viewController.present(alerta, animated: true, completion: nil)
            
        }
    }

    func abrirGaleria(_ viewController : UIViewController){
        
        alerta.dismiss(animated: true, completion: nil)
    
        selecionador.sourceType = .photoLibrary
    
        viewController.present(selecionador, animated: true, completion: nil)
        
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)
            
            guard let image = info[. originalImage] as? UIImage else {
                fatalError("espera uma imagem, mas foi pego o seguinte dado: \(info)")
            }
    
        retornoSelecionador?(image)
    }
    
    
}


