//
//  barsTests.swift
//  barsTests
//
//  Created by Jonathan on 29/01/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import XCTest
@testable import bars

class barsTests: XCTestCase {
    
    //Testando a classe Bar
    
    //Testa recebendo correto
    func testInicializaBarSucesso() {
        
        //Testando se a Classificação receber 0
        let zeroClassifica = Bar.init(nome: "zero", telefone: "992145598", long: 15, lati: 15, foto: nil, classifica: 0, numeroCasa: 10, rua: "São Paulo", bairro: "Itoupava")
        XCTAssertNotNil(zeroClassifica)
        
        //Testando se o telefone receber 8 DIGITOS
        let numeroDeTelefoneCerto = Bar.init(nome: "Positivo", telefone: "222223333", long: 15, lati: 15, foto: nil, classifica: 2, numeroCasa: 10, rua: "São Paulo", bairro: "Itoupava")
        XCTAssertNotNil(numeroDeTelefoneCerto)
        
        //Nome voltando não nil
        let nomeVoltandoNaoNil = Bar.init(nome: "Juka", telefone: "55558888", long: 1, lati: 1, foto: nil, classifica: 4, numeroCasa: 10, rua: "São Paulo", bairro: "Itoupava")
        XCTAssertNotNil(nomeVoltandoNaoNil)
        
        
        
        
    }
    //Teste recebendo errado
    func testInicializaBarFail() {
        
        //Classifica recebendo negativo
        let negativoClassifica = Bar.init(nome: "Negativo", telefone: "222233335", long: 156165158, lati: 156351454, foto: nil, classifica: -1, numeroCasa: 10, rua: "São Paulo", bairro: "Itoupava")
        XCTAssertNil(negativoClassifica)
        
        //Telefone recebendo menos de 9 Digitos
        let numeroDeTelefoneMenor = Bar.init(nome: "Menor", telefone: "2222333", long: 548161841, lati: 1564158815, foto: nil, classifica: 2, numeroCasa: 10, rua: "São Paulo", bairro: "Itoupava")
        XCTAssertNil(numeroDeTelefoneMenor)
        
        //Nome voltando nil
        let nomeVoltandoNil = Bar.init(nome: "", telefone: "32323232", long: 15, lati: 80, foto: nil, classifica: 4, numeroCasa: 10, rua: "São Paulo", bairro: "Itoupava")
        XCTAssertNil(nomeVoltandoNil)
        
        //Latitude e Longitude menor que o esperado, voltando nil
        let testLatiLongMenor = Bar.init(nome: "Juka", telefone: "33332222", long: -100, lati: -190, foto: nil, classifica: 1, numeroCasa: 10, rua: "São Paulo", bairro: "Itoupava")
        XCTAssertNil(testLatiLongMenor)
        
        //Latitude e Longitude maior que o esperado, voltando nil
        let testLatiLongMaior = Bar.init(nome: "Maior", telefone: "22522525", long: 200, lati: 200, foto: nil, classifica: 5, numeroCasa: 10, rua: "São Paulo", bairro: "Itoupava")
        XCTAssertNil(testLatiLongMaior)
        
        //Numero da Casa recebendo negativo, retornando nil
        let testNumeroCasaNegativo = Bar.init(nome: "Juka", telefone: "22225555", long: 15, lati: 15, foto: nil, classifica: 5, numeroCasa: -5, rua: "São Paulo", bairro: "Itoupava")
        XCTAssertNil(testNumeroCasaNegativo)
        
        //Endereço vazio, retornando nil
        let testEnderecoNil = Bar.init(nome: "Juka", telefone: "25525222", long: 15, lati: 15, foto: nil, classifica: 4, numeroCasa: 15, rua: "", bairro: "hgyh")
        XCTAssertNil(testEnderecoNil)
     
    }
    //Testando se as variáveis receber determinados valores
    func testEquals() {
        let testRecebendoClassificaMax = Bar.init(nome: "juha", telefone: "3314-1411", long: 18, lati: 9, foto: nil, classifica: 5, numeroCasa: 10, rua: "fsds", bairro: "fdsf")
        XCTAssertEqual(testRecebendoClassificaMax?.classifica, 5)

        let testRecebendoLatiLong = Bar.init(nome: "ki", telefone: "14521365", long: 180, lati: 15, foto: nil, classifica: 5, numeroCasa: 10, rua: "jui", bairro: "kil")
        XCTAssertEqual(testRecebendoLatiLong?.long, 180)
    }
    //Testando para dar errado
   // func testInicializandoComErros() {
        
   
   // }

}
