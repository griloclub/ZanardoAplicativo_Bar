//
//  Bar.swift
//  Bar
//
//  Created by Eduarda on 03/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit

class Bar {
    //Propriedades
    
    var nome : String
    var telefone : String
    var long : Float
    var lati : Float
    var foto : UIImage?
    var classifica : Int
    var numeroCasa : Int
    var rua : String
    var bairro : String
    
    //Inicializa(Construtor)
    init?(nome: String, telefone: String, long: Float, lati: Float, foto: UIImage?, classifica: Int, numeroCasa : Int, rua : String, bairro : String) {
        
        self.nome = nome
        self.telefone =  telefone
        self.long = long
        self.lati = lati
        self.foto = foto
        self.classifica =  classifica
        self.numeroCasa = numeroCasa
        self.rua = rua
        self.bairro = bairro
    
    //Verificação
        if nome.isEmpty || classifica < 0 || telefone.count < 8 || lati > 90 || lati < -90 || long > 180 || long < -180 || numeroCasa < 0 || rua.isEmpty || bairro.isEmpty {
            return nil;
        }
        
    }
}
