//
//  MonAnnotationView.swift
//  Les Calanques
//
//  Created by Kevin Trebossen on 29/09/2018.
//  Copyright © 2018 KTD. All rights reserved.
//

import UIKit
import MapKit

class MonAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupAnnotation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupAnnotation()
    }
    
    func setupAnnotation() {
        image = UIImage(named: "placeholder")
        canShowCallout = true
        
        leftCalloutAccessoryView = setupleft() // vue de accessible dans le popup
        rightCalloutAccessoryView = setupRight()
        detailCalloutAccessoryView = setupCenter() // image du centre
    }

    func setupleft() -> UIButton {      // signe distance à gauche du popup
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setImage(UIImage(named: "distance"), for: .normal)
        return button
    }
    
    func setupRight() -> UIButton {             // signe distance à gauche du popup
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setImage(UIImage(named: "detail"), for: .normal)
        return button
    }
    
    func setupCenter() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
        view.backgroundColor = .red
        return view
    }

}
