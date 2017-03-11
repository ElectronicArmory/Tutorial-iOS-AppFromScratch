//
//  BuildingsController.swift
//  Buildings
//
//  Created by Electronic Armory on 11/2/16.
//  Copyright © 2016 Electronic Armory. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation
import CoreData

class BuildingsController:NSObject{
    
    let NAME_KEY = "name"
    let LOCATION_KEY = "location"
    let DESCRIPTION_KEY = "description"
    let LATITUDE_KEY = "latitude"
    let LONGITUDE_KEY = "longitude"
    
    public static let BUILDING_ADDED_NOTIFICATION = NSNotification.Name("BUILDING_ADDED")
    
    static let buildingPinClassName:String = String(describing: MapPinModel.self)
    
    static var buildingsArray:Array = Array<MapPin>()
    
    class func sharedBuildings() -> Array<Any>{
        return buildingsArray
    }
    
    
    class func addBuilding( building:MapPin ){
        
        BuildingsController.buildingsArray.insert(building, at: 0)
        
        let newBuildingEntity:MapPinModel = NSEntityDescription.insertNewObject(forEntityName: buildingPinClassName, into: DatabaseController.getContext()) as! MapPinModel
        
        newBuildingEntity.pinTitle = building.title
        newBuildingEntity.pinDescription = building.subtitle
        newBuildingEntity.pinLatitude = building.coordinate.latitude
        newBuildingEntity.pinLongitude = building.coordinate.longitude
        
        NotificationCenter.default.post(name: BUILDING_ADDED_NOTIFICATION, object: building)
    }
    
    
    class func loadBuildings(){
        Alamofire.request("https://s3-us-west-2.amazonaws.com/electronic-armory/buildings.json").responseString{ response in
            do{
                let jsonString = response.result.value!
                let jsonData = jsonString.data(using: .utf8)!
                let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! NSArray
                
                for(_, jsonObject) in jsonArray.enumerated(){
                    let currentBuilding:Dictionary = jsonObject as! Dictionary<String, AnyObject>
                    
                    let nameString:String = currentBuilding[NAME_KEY] as! String
                    let descriptionString:String = currentBuilding[DESCRIPTION_KEY] as! String
                    
                    let locationDictionary:Dictionary = currentBuilding[LOCATION_KEY] as! Dictionary<String, Double>
                    let latitude:Double = locationDictionary[LATITUDE_KEY]! as Double
                    let longitude:Double = locationDictionary[LONGITUDE_KEY]! as Double
                    
                    let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                    
                    let currentMapPin:MapPin = MapPin(title: nameString, subtitle: descriptionString, coordinate: location)
                    
                    BuildingsController.addBuilding(building: currentMapPin)
                }
            }
            catch{
                print("error")
            }
        }
        
        print("called Alamofire")
    }
}
