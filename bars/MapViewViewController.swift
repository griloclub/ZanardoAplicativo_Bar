//
//  MapViewViewController.swift
//  bars
//
//  Created by Jonathan on 17/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import MapKit

class MapViewViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //definir localização inicial
        let inicialLocal = CLLocation(latitude: -26.917660, longitude: -49.070816)
        centerMapOnLocation(local: inicialLocal)
        //Definindo o delegate da vizualização do mapa
        mapView.delegate = self
        //Criando uma anotação no mapa
        let atWork = Atwork(title: "Predio de Blumenau", localNome: "Centro Blumenau", tipo: "Predio Comercial", cordinate: CLLocationCoordinate2D(latitude: -26.914919, longitude:  -49.071437))
        mapView.addAnnotation(atWork)
        // Do any additional setup after loading the view.
    }
    let regiaoRaio : CLLocationDistance = 1000
    
    func centerMapOnLocation(local : CLLocation) {
        let cordenadasRegiao = MKCoordinateRegion(center: local.coordinate, latitudinalMeters: regiaoRaio, longitudinalMeters: regiaoRaio)
        
        mapView.setRegion(cordenadasRegiao, animated: true)
    }
}
    extension MapViewViewController : MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? Atwork
                else {
                    return nil
                }
            let identifier = "marker"
            var view : MKMarkerAnnotationView
            
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as?
                MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
                } else {
                    view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    view.canShowCallout = true
                    view.calloutOffset = CGPoint( x: -5, y: 5)
                    view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                    }
                return view
            }
        //Aqui estou abrindo uma biblioteca do maps,onde ao cliclar no botão de mais informações no lugar setado o usuario será direcionado ao aplicativo maps
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            let location = view.annotation as! Atwork
            let launchOpitions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            
            location.mapItem().openInMaps(launchOptions: launchOpitions)
        }
    }



