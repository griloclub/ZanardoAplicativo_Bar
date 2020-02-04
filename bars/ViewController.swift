//
//  ViewController.swift
//  bars
//
//  Created by Jonathan on 29/01/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textNome: UITextField!
    @IBOutlet weak var textTelefone: UITextField!
    @IBOutlet weak var textEndereco: UITextField!
    
   @IBOutlet weak var imagem: UIImageView!
    
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
        textEndereco.delegate = self;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var nomeCampo : String!
       switch textField {
            case textNome :
                nomeCampo = "Bar: "
                break
            case textEndereco :
                nomeCampo = "Endereço: "
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
}

//classe para acessar a galeria

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


