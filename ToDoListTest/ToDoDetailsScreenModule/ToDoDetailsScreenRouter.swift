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
}

enum ToDoDetailsScreenViewBuilderRoutes {
    case saveTaskChanges(Todo)
}

class ToDoDetailsScreenRouter: ToDoDetailsScreenRouterProtocol {

    weak var viewController: ToDoDetailsScreenViewControllerProtocol?
    
    var routes: ((ToDoDetailsScreenViewBuilderRoutes) -> Void)?
    
    func saveTaskChanges(task: Todo) {
        routes?(.saveTaskChanges(task))
    }
}
