//
//  Subitem+CoreDataClass.swift
//  MergePolicyExample
//
//  Created by Andrey Chuprina on 1/25/19.
//  Copyright © 2019 Andriy Chuprina. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Subitem)
public class Subitem: NSManagedObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name
    }

    public required convenience init(from decoder: Decoder) throws {
        let context = decoder.userInfo[CodingUserInfoKey.context!] as! NSManagedObjectContext
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let description = Subitem.entity()
        self.init(entity: description, insertInto: context)
        
        if let name = try container.decodeIfPresent(String.self, forKey: .name) {
            self.name = name
        }
        
    }
    
}
