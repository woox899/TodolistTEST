//
//  ToDoDetailsPresenter.swift
//  ToDoListTest
//
//  Created by Андрей Бабкин on 27.08.2024.
//

import UIKit

protocol ToDoDetailsScreenPresenterProtocol: AnyObject {
    func presentNewTask() // от Interactor
    func presentTaskDetails(task: Todo)

    func viewDidLoaded() // от ViweController
    func saveNewTaskChanges(task: Todo)
    func addNewTask(task: TodoRequest)
}

class ToDoDetailsScreenPresenter: ToDoDetailsScreenPresenterProtocol {
    
    weak var viewController: ToDoDetailsScreenViewControllerProtocol?
    var interactor: ToDoDetailsScreenInteractorProtocol
    var router: ToDoDetailsScreenRouterProtocol
    
    init(interactor: ToDoDetailsScreenInteractorProtocol, router: ToDoDetailsScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }

    func presentNewTask() {
        viewController?.displayNewTask()
    }
    
    func presentTaskDetails(task: Todo) {
        let entity = TodoDetailsScreenEntity.TodoDetailsTaskModel(todo: task)
        viewController?.displayTaskDetails(task: entity)
    }

    func viewDidLoaded() {
        interactor.viewDidLoaded()
    }
    
    func saveNewTaskChanges(task: Todo) {
        router.saveTaskChanges(task: task)
    }
    
    func addNewTask(task: TodoRequest) {
        router.addNewTask(task: task)
    }
}
