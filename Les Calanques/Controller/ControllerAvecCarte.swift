//
//  ControllerAvecCarte.swift
//  Les Calanques
//
//  Created by Kevin Trebossen on 23/09/18.
//  Copyright © 2018 KTD. All rights reserved.
//

import UIKit
import MapKit

class ControllerAvecCarte: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var calanques: [Calanque] = CalanqueCollection().all()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        addAnnotation()
    }
    
    func addAnnotation() {
        for calanque in calanques {
            
            /* //------- V1 Annotation de base
            let annotation = MKPointAnnotation()
            annotation.coordinate = calanque.coordonnee
            annotation.title = calanque.nom
            mapView.addAnnotation(annotation) */
            
            // Annotation Custom
            let annotation = MonAnnotation(calanque)
            mapView.addAnnotation(annotation)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "reuseID"
        
        // Vérifier que ce ne soit pas la position de l'utilisateur
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        if let anno = annotation as? MonAnnotation {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: anno, reuseIdentifier: reuseIdentifier)
                annotationView?.image = UIImage(named: "placeholder")
                annotationView?.canShowCallout = true
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
        
        
    }


}
