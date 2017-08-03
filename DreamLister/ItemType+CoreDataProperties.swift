//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Diparth Patel on 5/29/17.
//  Copyright © 2017 Diparth Patel. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType")
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
