//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Diparth Patel on 5/29/17.
//  Copyright © 2017 Diparth Patel. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate.init()
        
    }
    
}
