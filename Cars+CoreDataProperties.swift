//
//  Cars+CoreDataProperties.swift
//  focusStart
//
//  Created by Mikhail Sergeev on 28.01.2020.
//  Copyright © 2020 Mikhail Sergeev. All rights reserved.
//
//

import Foundation
import CoreData


extension Cars {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cars> {
        return NSFetchRequest<Cars>(entityName: "Cars")
    }

    @NSManaged public var manufacturer: String?
    @NSManaged public var model: String?
    @NSManaged public var body: String?
    @NSManaged public var year: String?

}
