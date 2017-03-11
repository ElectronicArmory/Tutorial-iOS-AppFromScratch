//
//  MapPin.swift
//  Buildings
//
//  Created by Electronic Armory on 11/2/16.
//  Copyright © 2016 Electronic Armory. All rights reserved.
//

import MapKit

class MapPin: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title:String, subtitle:String, coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
