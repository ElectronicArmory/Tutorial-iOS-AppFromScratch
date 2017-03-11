//
//  ViewController.swift
//  Buildings
//
//  Created by Electronic Armory on 11/1/16.
//  Copyright © 2016 Electronic Armory. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        NotificationCenter.default.addObserver(forName: BuildingsController.BUILDING_ADDED_NOTIFICATION, object: nil, queue: nil){ notification in
            let newBuildingPin:MapPin = notification.object as! MapPin
            
            self.mapView.addAnnotation(newBuildingPin)
        }
        
        let buildingsArray:Array = BuildingsController.sharedBuildings()
        for(_, currentObject) in buildingsArray.enumerated(){
            let buildingPin:MapPin = currentObject as! MapPin
            
            mapView.addAnnotation(buildingPin)
        }
        
        let distanceSpan:CLLocationDegrees = 2000
        let bsuCSCampusLocation:CLLocationCoordinate2D = LocationsController.deviceLocation()
        if( bsuCSCampusLocation.latitude != 0.0 ){
            mapView.setRegion(MKCoordinateRegionMakeWithDistance(bsuCSCampusLocation, distanceSpan, distanceSpan), animated: true)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

