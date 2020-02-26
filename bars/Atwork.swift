//
//  Atwork.swift
//  bars
//
//  Created by Eduarda on 17/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//
import Foundation
import MapKit
import Contacts

class Atwork : NSObject, MKAnnotation {
    
    var bar : Bar?
    
    let title: String?
    let localNome : String?
    let classificacao : Int?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, localNome : String, classificacao : Int, cordinate : CLLocationCoordinate2D) {
        
        self.localNome = localNome
        self.title =  title
        self.classificacao = classificacao
        self.coordinate = cordinate
        
        super.init()
    }
    var subtitle: String? {
        return localNome
    }
    
    //Listando todos os bares no maps
    init?(bar: Bar) {
        self.localNome = bar.bairro
        self.title = bar.nome
        self.classificacao = bar.classifica
        self.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(bar.lati), longitude: CLLocationDegrees(bar.long))
    }
    
    //O Botão de informações que fica a direita das anotações irá abrir este mapItem no aplicativo de mapas
    func mapItem() -> MKMapItem {
        
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
}
