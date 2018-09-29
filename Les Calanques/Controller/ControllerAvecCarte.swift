//
//  ControllerAvecCarte.swift
//  Les Calanques
//
//  Created by Kevin Trebossen on 23/09/18.
//  Copyright © 2018 KTD. All rights reserved.
//

import UIKit
import MapKit

class ControllerAvecCarte: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var userPosition: CLLocation?
    var calanques: [Calanque] = CalanqueCollection().all()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self     // nécessaire suite à l'héritage du MKMapViewDelegate
        locationManager.delegate = self
        mapView.showsUserLocation = true    // montre la position de l'utilisateur
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()     // Demande si on peut localiser l'utilisateur 
        addAnnotation()
        NotificationCenter.default.addObserver(self, selector: #selector(notifDetail), name: Notification.Name("detail"), object: nil)  // Ecoute les notifications
        if calanques.count > 5 {            // Centrer la vue sur les calanques
            let premiere = calanques[0].coordonnee
            setupMap(coordonnees: premiere)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            if let maPosition = locations.last {
                userPosition = maPosition
                
            }
        }
    }
    
    
    // centrer la carte
    func setupMap(coordonnees: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.35, longitudeDelta: 0.35)      // 0.01 -> rue || 4 -> très loin
        let region = MKCoordinateRegion(center: coordonnees, span: span)        // définir une région
        mapView.setRegion(region, animated: true)
        
    }
    
    @objc func notifDetail(notification: Notification) {
        if let calanque = notification.object as? Calanque {
            print ("Jai une calanque")
            toDetail(calanque: calanque)
        }
    }
    
    func toDetail(calanque: Calanque) {
        performSegue(withIdentifier: "Detail", sender: calanque)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            if let controller = segue.destination as? DetailController {
                controller.calanqueRecue = sender as? Calanque
            }
        }
    }
    
    func addAnnotation() {
        for calanque in calanques {
            
            // Annotation Custom - V2
            let annotation = MonAnnotation(calanque)
            mapView.addAnnotation(annotation)
            
            /* //------- V1 Annotation de base
            let annotation = MKPointAnnotation()
            annotation.coordinate = calanque.coordonnee
            annotation.title = calanque.nom
            mapView.addAnnotation(annotation) */
        }
    }
    
    // Annotations sur la carte
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "reuseID"
        
        // Vérifier que ce ne soit pas la position de l'utilisateur
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        if let anno = annotation as? MonAnnotation {                                                // -----------  annotation personnalisée --------- //
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
            if annotationView == nil {
                
                // override
                //annotationView = MonAnnotationView(annotation: anno, reuseIdentifier: reuseIdentifier)
                
                annotationView = MonAnnotationView(controller: self, annotation: anno, reuseIdentifier: reuseIdentifier)
                
                //annotationView = MKAnnotationView(annotation: anno, reuseIdentifier: reuseIdentifier)
                //annotationView?.image = UIImage(named: "placeholder")
                //annotationView?.canShowCallout = true
                return annotationView
            } else {
                return annotationView
            }
        }
        return nil  // nil si ce n'est pas la position de l'utilisateur ni les autres positions
    }
    
    
    
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {         // les différents types de cartes
        switch sender.selectedSegmentIndex {
        case 0: mapView.mapType = MKMapType.standard
        case 1: mapView.mapType = .satellite
        case 2: mapView.mapType = .hybrid
        default: break
        }
    }
    
    
    @IBAction func getPosition(_ sender: Any) {
        if userPosition != nil {
            setupMap(coordonnees: userPosition!.coordinate)
        }
        
    }


}
