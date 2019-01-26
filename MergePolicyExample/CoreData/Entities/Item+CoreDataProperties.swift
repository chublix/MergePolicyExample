//
//  Item+CoreDataProperties.swift
//  MergePolicyExample
//
//  Created by Andrey Chuprina on 1/26/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: Int32
    @NSManaged public var info: String?
    @NSManaged public var name: String?

}
