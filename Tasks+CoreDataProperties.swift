//
//  Tasks+CoreDataProperties.swift
//  ToDoListTest
//
//  Created by Андрей Бабкин on 31.08.2024.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var taskName: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var dateCreation: Date?
    @NSManaged public var status: Bool
    @NSManaged public var id: String?

}

extension Tasks : Identifiable {

}
