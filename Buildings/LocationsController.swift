//
//  LocationsController.swift
//  Buildings
//
//  Created by Electronic Armory on 11/2/16.
//  Copyright © 2016 Electronic Armory. All rights reserved.
//

import Foundation
import CoreLocation

class LocationsController:NSObject, CLLocationManagerDelegate{
    
    static let sharedLocationController:LocationsController = LocationsController()
    
    static var currentLocation:CLLocation? = nil
    static let locationManager:CLLocationManager = CLLocationManager()
    
    class func startGPS(){
        locationManager.delegate = sharedLocationController
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.startUpdatingLocation()
        
        locationManager.requestAlwaysAuthorization()
        
        let coordinateOne:CLLocationCoordinate2D  = CLLocationCoordinate2DMake( 40.741895, -73.989308)
        let coordinateTwo:CLLocationCoordinate2D  = CLLocationCoordinate2DMake( 40.728527, -74.208526)
        let locationsArray:NSArray = [coordinateOne, coordinateTwo]
        
        print(locationsArray[0])
        print(locationsArray[1])
    }
    
    class func stopGPS(){
        locationManager.stopUpdatingLocation()
    }
    
    class func deviceLocation() -> CLLocationCoordinate2D{
        if( currentLocation != nil ){
            return (currentLocation?.coordinate)!
        }
        else{
            return CLLocationCoordinate2DMake(0.0, 0.0)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        LocationsController.currentLocation = locations[0]
    }
}
