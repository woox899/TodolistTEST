//
//  MainScreenPresenter.swift
//  ToDoList
//
//  Created by Андрей Бабкин on 26.08.2024.
//

import UIKit

protocol MainScreenPresenterProtocol: AnyObject {
    func presentFilledTasks(tasks: TodoListModel)

    func viewDidLoaded()
    func didTapRow(task: Todo)
    func didTapCreateNewTaskButton()
}

class MainScreenPresenter: MainScreenPresenterProtocol {
    weak var viewController: MainScreenViewControllerProtocol?
    var interactor: MainScreenInteractorProtocol
    var router: MainScreenRouterProtocol
    
    func viewDidLoaded() {
        interactor.loadTasks()
    }
    
    func presentFilledTasks(tasks: TodoListModel) {
        let entity = MainScreenEntity.MainScreenTodoList(list: tasks)
        viewController?.displayFilledTasks(tasks: entity)
    }
    
    func didTapRow(task: Todo) {
        router.openDetailsScreen(task: task)
    }

    func didTapCreateNewTaskButton() {
        router.openCreateNewTaskScreen() { [weak self] task in
            let entity = MainScreenEntity.MainScreenNewTask(task: task)
            self?.viewController?.displayNewAddedTask(model: entity)
        }
    }
    
    init(interactor: MainScreenInteractorProtocol, router: MainScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
