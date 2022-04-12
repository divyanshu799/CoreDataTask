//
//  Person+CoreDataProperties.swift
//  NewCoreData
//
//  Created by Apple User on 08/04/22.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?

}


