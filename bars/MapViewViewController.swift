//
//  MapViewViewController.swift
//  bars
//
//  Created by Eduarda on 17/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
   // var bares: [ Atwork ] = []
    var locationManager = CLLocationManager()
    var savedBars: [Bar]?
    var bar : Bar!
    var selectedAnnotation: Bar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    
        //Autorização
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
      
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            locationManager.requestLocation()
        
        }
        carregaBarsAnotacao()
        
        mapView.delegate = self
    
       // mapView.addAnnotation(bares as! MKAnnotation)
        
        //Criando uma anotação no mapa
        /*let atWork = Atwork(title: "Predio de Blumenau", localNome: "Centro Blumenau", classificacao: 3, cordinate: CLLocationCoordinate2D(latitude: -26.914919, longitude:  -49.071437))
        mapView.addAnnotation(atWork)*/
       
    }
    //Mostrando mapa como satelite

    @IBAction func btnStatelite(_ sender: Any) {
        self.mapView.mapType = MKMapType.satellite
    }
    
    func carregaBarsAnotacao() {
        savedBars = NSKeyedUnarchiver.unarchiveObject(withFile : Bar.ArchiveURL.path) as? [Bar] ?? [Bar]()
        print(bar)
        if (savedBars!.isEmpty) {
            let atWork1 = Atwork(title: "Bar do Juka", localNome: "Centro - Blumenau", classificacao: 3, cordinate: CLLocationCoordinate2D(latitude: -26.914919, longitude:  -49.071437))
            mapView.addAnnotation(atWork1)
            
            let atWork2 = Atwork(title: "Bar do tijolão", localNome: "Centro - Blumenau", classificacao: 4, cordinate: CLLocationCoordinate2D(latitude: -26.913993, longitude:  -49.070781))
            mapView.addAnnotation(atWork2)
           
        } else {
            for bar in savedBars! {
                let atwork = Atwork(bar: bar)!;
                mapView.addAnnotation(atwork)
            }
        }
    }
      
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let UserLocation : CLLocation = locations [0] as CLLocation
        let location = CLLocationCoordinate2D(latitude: UserLocation.coordinate.latitude, longitude: UserLocation.coordinate.longitude)
        let latitudeDelta: CLLocationDegrees = 0.01
        let longitudeDelta: CLLocationDegrees = 0.01
        let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        let center = CLLocationCoordinate2DMake(location.latitude, location.longitude)
        let region = MKCoordinateRegion(center: center, span: span)
        self.mapView.setRegion(region, animated: false)
        }
    
    // updateMapCenter(manager: manager)
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
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
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            
            for bar in savedBars! {
                if(bar.nome == view.annotation?.title) {
                    selectedAnnotation = bar
                }
            }
           
            performSegue(withIdentifier: "showFromMap", sender: MKAnnotationView.self)
            
            }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?){
            if segue.identifier == "showFromMap"{
                let destino = segue.destination as! BarViewController
                
                destino.bar = selectedAnnotation
            }
        }
    }



