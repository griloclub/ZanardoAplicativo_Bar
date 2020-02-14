//
//  Bar.swift
//  Bar
//
//  Created by Eduarda on 03/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import os.log
/*Nossa classe modelo é responsavel em declarar todas as propriedades do objeto que estamos
 ultilizamos */
class Bar : NSObject, NSCoding {
    
    //MARK: Propriedades
    var nome : String
    var telefone : String
    var long : Float
    var lati : Float
    var foto : UIImage?
    var classifica : Int
    var numeroCasa : Int
    var rua : String
    var bairro : String
    
    //MARK: Arquivos Dados
    static var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("bares")
    
    //MARK: Tipos
    struct PropriedadeKey {
        static let nome = "nome"
        static let telefone = "telefone"
        static let long = "long"
        static let lati = "lati"
        static let foto = "foto"
        static let classifica = "classifica"
        static let numeroCasa = "numeroCasa"
        static let rua = "rua"
        static let bairro = "bairro"
        
    }
    //MARK: Inicializa(Construtor)
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
        guard (classifica >= 0) && (classifica <= 5) else{
            return nil
        }
        guard (lati <= 90) && (lati >= -90) else {
            return nil
        }
        guard (long <= 180) && (long >= -180) else {
            return nil
        }
        
        if nome.isEmpty || telefone.count < 8 || numeroCasa < 0 || rua.isEmpty || bairro.isEmpty {
            return nil;
        }
        
    }
    //MARK: Iniciador do NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nome, forKey: PropriedadeKey.nome)
        aCoder.encode(telefone, forKey: PropriedadeKey.telefone)
        aCoder.encode(long, forKey: PropriedadeKey.long)
        aCoder.encode(lati, forKey: PropriedadeKey.lati)
        aCoder.encode(foto, forKey: PropriedadeKey.foto)
        aCoder.encode(classifica, forKey: PropriedadeKey.classifica)
        aCoder.encode(numeroCasa, forKey: PropriedadeKey.numeroCasa)
        aCoder.encode(rua, forKey: PropriedadeKey.rua)
        aCoder.encode(bairro, forKey: PropriedadeKey.bairro)
        
        
    }

    //Convenience é um inicializador secundario e deve chamar um inicializador designado da classe
    required convenience init?(coder aDecoder : NSCoder) {
        
        guard let nome = aDecoder.decodeObject(forKey : PropriedadeKey.nome) as? String
            else {
                os_log("O nome nao foi identificado", log: OSLog.default, type: .debug)
            return nil
        }
            
        let foto = aDecoder.decodeObject(forKey : PropriedadeKey.foto) as? UIImage
        let telefone = aDecoder.decodeObject(forKey : PropriedadeKey.telefone) as? String
        let lati = aDecoder.decodeFloat(forKey : PropriedadeKey.lati)
        let long = aDecoder.decodeFloat(forKey : PropriedadeKey.long)
        let classifica = aDecoder.decodeInteger(forKey: PropriedadeKey.classifica)
        let rua = aDecoder.decodeObject(forKey : PropriedadeKey.rua) as? String
        let bairro = aDecoder.decodeObject(forKey : PropriedadeKey.bairro) as? String
        let numeroCasa = aDecoder.decodeInteger(forKey : PropriedadeKey.numeroCasa)
        
        self.init(nome: nome, telefone: telefone!, long: long, lati: lati, foto: foto, classifica: classifica, numeroCasa: numeroCasa, rua: rua!, bairro: bairro!)
        
        }
    }

