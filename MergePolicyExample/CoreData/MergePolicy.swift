//
//  MergePolicy.swift
//  MergePolicyExample
//
//  Created by Andrey Chuprina on 1/23/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//

import CoreData


class MergePolicy: NSMergePolicy {

    class func create() -> MergePolicy {
        return MergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
    }
    
    private override init(merge ty: NSMergePolicyType) {
        super.init(merge: ty)
    }

    override func resolve(constraintConflicts list: [NSConstraintConflict]) throws {
        for conflict in list {
            guard let databaseObject = conflict.databaseObject else {
                try super.resolve(constraintConflicts: list)
                return
            }
            
            let allKeys = databaseObject.entity.attributesByName.keys
            
            for conflictObject in conflict.conflictingObjects {
                let changedKeys = conflictObject.changedValues().keys
                let keys = allKeys.filter { !changedKeys.contains($0) }
                for key in keys {
                    let value = databaseObject.value(forKey: key)
                    conflictObject.setValue(value, forKey: key)
                }
            }
        }
        try super.resolve(constraintConflicts: list)
    }
    
}
