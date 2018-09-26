//
//  MonAnnotation.swift
//  Les Calanques
//
//  Created by Kevin Trebossen on 26/09/2018.
//  Copyright © 2018 KTD. All rights reserved.
//

import MapKit
import UIKit

class MonAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var calanque: Calanque
    var title: String?
    
    init(_ calanque: Calanque) {
        self.calanque = calanque
        coordinate = self.calanque.coordonnee
        title = self.calanque.nom
    }
    
    
}
