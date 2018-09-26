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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) { // les différents types de cartes
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
