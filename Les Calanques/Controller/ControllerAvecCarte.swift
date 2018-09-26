//
//  ControllerAvecCarte.swift
//  Les Calanques
//
//  Created by Kevin Trebossen on 23/09/18.
//  Copyright © 2018 KTD. All rights reserved.
//

import UIKit
import MapKit

class ControllerAvecCarte: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var calanques: [Calanque] = CalanqueCollection().all()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAnnotation()
    }
    
    func addAnnotation() {
        for calanque in calanques {
            let annotation = MKPointAnnotation()
            annotation.coordinate = calanque.coordonnee
            annotation.title = calanque.nom
            mapView.addAnnotation(annotation)
        }
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
