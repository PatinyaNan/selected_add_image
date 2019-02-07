//
//  Item+CoreDataProperties.swift
//  Co-Grocery-Image
//
//  Created by Admin on 5/2/2562 BE.
//  Copyright © 2562 Admin. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var imaage: NSData?
    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var qty: String?

}
