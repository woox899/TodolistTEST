//
//  CoreManger.swift
//  ToDoListTest
//
//  Created by Андрей Бабкин on 31.08.2024.
//

import Foundation
import CoreData

class CoreManger {
    static let shared = CoreManger()
    
    var tasks = [Tasks]()
    
    init() {
        fetchAllTasks() // - пока что здесь
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDoListTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchAllTasks() {
        let req = Tasks.fetchRequest()
        if let tasks = try? persistentContainer.viewContext.fetch(req) {
            self.tasks = tasks
        }
    }
    
    func addNewTask(id: Int16, taskName: String, taskDescription: String, status: Bool, date: Date) {
        let task = Tasks(context: persistentContainer.viewContext)
        task.taskName = taskName
        task.taskDescription = taskDescription
        task.status = status
        task.id = id
        
        saveContext()
        fetchAllTasks()
    }
}
