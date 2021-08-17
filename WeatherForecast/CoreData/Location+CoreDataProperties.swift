//
//  Location+CoreDataProperties.swift
//  WeatherForecast
//
//  Created by dattaphani on 07/08/21.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var locationTitle: String?
    @NSManaged public var date: Date?
    @NSManaged public var latitude: NSNumber?
    @NSManaged public var locationDescription: String?
    @NSManaged public var longitude: NSNumber?

}

extension Location : Identifiable {

}
