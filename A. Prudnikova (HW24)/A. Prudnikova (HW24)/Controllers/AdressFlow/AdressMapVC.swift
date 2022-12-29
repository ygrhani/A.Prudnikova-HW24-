//
//  AdressMapVC.swift
//  A. Prudnikova (HW24)
//
//  Created by Рабочая лошадка  on 27.12.22.
//

import UIKit
import GoogleMaps

class AdressMapVC: UIViewController, GMSMapViewDelegate {
    
    var latitude: Double = 0
    var longitude: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        view.insertSubview(mapView, at: 0)
        mapView.delegate = self
        print(latitude)
        print(longitude)
        
    }
}
