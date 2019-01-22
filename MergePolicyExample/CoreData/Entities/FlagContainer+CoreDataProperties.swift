//
//  FlagContainer+CoreDataProperties.swift
//  MergePolicyExample
//
//  Created by Andrey Chuprina on 1/22/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//
//

import Foundation
import CoreData


extension FlagContainer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlagContainer> {
        return NSFetchRequest<FlagContainer>(entityName: "FlagContainer")
    }

    @NSManaged public var flag: Bool
    @NSManaged public var item: Item?

}
