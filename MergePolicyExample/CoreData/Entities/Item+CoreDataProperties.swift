//
//  Item+CoreDataProperties.swift
//  MergePolicyExample
//
//  Created by Andrey Chuprina on 1/25/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: String?
    @NSManaged public var info: String?
    @NSManaged public var name: String?
    @NSManaged public var subitems: NSSet?

}

// MARK: Generated accessors for subitems
extension Item {

    @objc(addSubitemsObject:)
    @NSManaged public func addToSubitems(_ value: Subitem)

    @objc(removeSubitemsObject:)
    @NSManaged public func removeFromSubitems(_ value: Subitem)

    @objc(addSubitems:)
    @NSManaged public func addToSubitems(_ values: NSSet)

    @objc(removeSubitems:)
    @NSManaged public func removeFromSubitems(_ values: NSSet)

}
