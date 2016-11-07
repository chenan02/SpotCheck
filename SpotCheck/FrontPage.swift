//
//  FrontPage.swift
//  SpotCheck
//
//  Created by Andrew Chen on 10/13/16.
//  Copyright © 2016 Spot Check. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class FrontPage: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var latitude = locations[0].coordinate.latitude
        var longitude = locations[0].coordinate.longitude
    }
    
    @IBAction func searchMap(_ sender: Any) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

