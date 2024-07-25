//
//  CDPasswordEntry+CoreDataProperties.swift
//  PasswordManager
//
//  Created by Ramya K on 24/07/24.
//
//

import Foundation
import CoreData


extension CDPasswordEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPasswordEntry> {
        return NSFetchRequest<CDPasswordEntry>(entityName: "CDPasswordEntry")
    }

    @NSManaged public var accountType: String
    @NSManaged public var password: String
    @NSManaged public var username: String

}

extension CDPasswordEntry : Identifiable {

}


