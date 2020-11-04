//
//  Favourite+CoreDataProperties.swift
//  Weathered
//
//  Created by Michael Amiro on 04/11/2020.
//  Copyright © 2020 Michael Amiro. All rights reserved.
//
//

import Foundation
import CoreData


extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }

    @NSManaged public var name: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}
