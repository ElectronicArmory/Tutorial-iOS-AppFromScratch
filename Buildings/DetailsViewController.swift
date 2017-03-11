//
//  DetailsViewController.swift
//  Buildings
//
//  Created by Electronic Armory on 11/2/16.
//  Copyright © 2016 Electronic Armory. All rights reserved.
//

import UIKit
import MapKit


class DetailsViewController:UIViewController{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        let nameString:String = nameTextField.text!
        let descriptionString:String = descriptionTextField.text!
        
        let newMapPin:MapPin = MapPin(title: nameString, subtitle: descriptionString, coordinate: LocationsController.deviceLocation())
        
        BuildingsController.addBuilding(building: newMapPin)

//        DatabaseController.saveContext()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
