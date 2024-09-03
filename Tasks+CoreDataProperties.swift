//
//  Tasks+CoreDataProperties.swift
//  ToDoListTest
//
//  Created by Андрей Бабкин on 31.08.2024.
//
//

import Foundation
import CoreData

@objc(Tasks)
public class Tasks: NSManagedObject {
    
}

extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var taskName: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var dateCreation: Date?
    @NSManaged public var status: Bool
    @NSManaged public var id: Int16

}

extension Tasks : Identifiable {
    
    func updateTasks(newTaskName: String, newTaskDescription: String) {
        self.taskName = newTaskName
        self.taskDescription = newTaskDescription
        self.dateCreation = Date()
        
        try? managedObjectContext?.save()
    }
    
    func deliteTask() {
        managedObjectContext?.delete(self)
        try? managedObjectContext?.save()
    }

}
