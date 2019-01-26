//
//  Subitem+CoreDataProperties.swift
//  MergePolicyExample
//
//  Created by Andrey Chuprina on 1/26/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//
//

import Foundation
import CoreData


extension Subitem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subitem> {
        return NSFetchRequest<Subitem>(entityName: "Subitem")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var val: Int32
    @NSManaged public var item: Item?

}
