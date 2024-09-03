//
//  ToDoDetailsRouter.swift
//  ToDoListTest
//
//  Created by Андрей Бабкин on 27.08.2024.
//

import UIKit

protocol ToDoDetailsScreenRouterProtocol: AnyObject {
    var routes: ((ToDoDetailsScreenViewBuilderRoutes) -> Void)? { get set }
    func saveTaskChanges(task: Todo)
    func addNewTask(task: TodoRequest)
}

enum ToDoDetailsScreenViewBuilderRoutes {
    case saveTaskChanges(Todo)
    case addTask(TodoRequest)
}

class ToDoDetailsScreenRouter: ToDoDetailsScreenRouterProtocol {

    weak var viewController: ToDoDetailsScreenViewControllerProtocol?
    
    var routes: ((ToDoDetailsScreenViewBuilderRoutes) -> Void)?
    
    func saveTaskChanges(task: Todo) {
        routes?(.saveTaskChanges(task))
    }

    func addNewTask(task: TodoRequest) {
        routes?(.addTask(task))
    }
}
