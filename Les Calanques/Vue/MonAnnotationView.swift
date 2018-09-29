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
    
    var controller: ControllerAvecCarte?
    
    init(controller: ControllerAvecCarte,annotation: MKAnnotation?, reuseIdentifier: String?) {
        self.controller = controller
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupAnnotation()
    }
    
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
        button.addTarget(self, action: #selector(gps), for: .touchUpInside)      // donne une action sur le bouton
        return button
    }
    
    func setupRight() -> UIButton {             // signe distance à gauche du popup
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setImage(UIImage(named: "detail"), for: .normal)
        button.addTarget(self, action: #selector(detail), for: .touchUpInside)      // donne une action sur le bouton
        return button
    }
    
    func setupCenter() -> UIView? {
        guard let anno = annotation as? MonAnnotation else { return nil }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 125, height: 125))
        view.translatesAutoresizingMaskIntoConstraints = false // ne pas transformer la vue automatiquement
        view.widthAnchor.constraint(equalToConstant: 125).isActive = true
        view.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
        let imageView = UIImageView(frame: view.bounds)
        imageView.image = anno.calanque.image
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        return view
    }
    
    @objc func detail() {
        guard let anno = annotation as? MonAnnotation else { return }
        
        //-V1
        //controller?.toDetail(calanque: anno.calanque)
        
        //-V2
        NotificationCenter.default.post(name: Notification.Name("detail"), object: anno.calanque)
    }
    
    @objc func gps() {
        
    }

}
