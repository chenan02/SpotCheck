//
//  MapController.swift
//  SpotCheck
//
//  Created by Andrew Chen on 10/13/16.
//  Copyright © 2016 Spot Check. All rights reserved.
//

import UIKit
import GoogleMaps

class MapController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createImage(_ count: Int) -> UIImage {
        //count is the integer that has to be shown on the marker
        let color = UIColor.orange
        // select needed color
        let string = "\(UInt(count))"
        // the string to colorize
        let attrs = [NSForegroundColorAttributeName: color]
        let attrStr = NSAttributedString(string: string, attributes: attrs)
        // add Font according to your need
        let image = UIImage(named: "Mod_Marker.png")!
        // The image on which text has to be added
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let rect = CGRect(x: 26, y: 5, width: image.size.width, height: image.size.height)
        // change the frame of your text from here
        Set<AnyHashable>()
        attrStr.draw(in: rect)
        let markerImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return markerImage
    }
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 15.5)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        var intVal = 5

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
      //  marker.icon = GMSMarker.markerImage(with: UIColor.white)
        marker.icon = self.createImage(intVal)

    }

}

