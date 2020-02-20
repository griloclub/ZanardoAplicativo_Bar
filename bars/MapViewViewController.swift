//
//  MapViewViewController.swift
//  bars
//
//  Created by Jonathan on 17/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
   // var bares: [ Atwork ] = []
    var locationManager = CLLocationManager()
    var bares = [Atwork]()
    var bar : Bar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        //Mostrando mapa como satelite
       
        
    
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
        
    
       // mapView.addAnnotation(bares as! MKAnnotation)
        
        //Criando uma anotação no mapa
        /*let atWork = Atwork(title: "Predio de Blumenau", localNome: "Centro Blumenau", classificacao: 3, cordinate: CLLocationCoordinate2D(latitude: -26.914919, longitude:  -49.071437))
        mapView.addAnnotation(atWork)*/
       
    }
    @IBAction func btnStatelite(_ sender: Any) {
        self.mapView.mapType = MKMapType.satellite
    }
    
    func carregaBarsAnotacao() {
        var savedBars = NSKeyedUnarchiver.unarchiveObject(withFile : Bar.ArchiveURL.path) as? [Bar] ?? [Bar]()
        print(bar)
        if (savedBars.isEmpty) {
            let atWork1 = Atwork(title: "Bar do Juka", localNome: "Centro - Blumenau", classificacao: 3, cordinate: CLLocationCoordinate2D(latitude: -26.914919, longitude:  -49.071437))
            mapView.addAnnotation(atWork1)
            
            let atWork2 = Atwork(title: "Bar do tijolão", localNome: "Centro - Blumenau", classificacao: 4, cordinate: CLLocationCoordinate2D(latitude: -26.913993, longitude:  -49.070781))
            mapView.addAnnotation(atWork2)
           
        } else {
            for bar in savedBars {
                let atwork = Atwork(bar: bar)!;
                let anotacao = MKPointAnnotation()
                anotacao.title = atwork.title
                anotacao.coordinate = CLLocationCoordinate2D(
                    latitude: atwork.coordinate.latitude,
                    longitude: atwork.coordinate.longitude
                )
                mapView.addAnnotation(anotacao)
                print(anotacao)
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
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    
                let location = view.annotation as! Atwork
                let launchOpitions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
            
                location.mapItem().openInMaps(launchOptions: launchOpitions)
            }
        
    }



