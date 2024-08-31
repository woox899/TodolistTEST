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
    func taskCompletedValueChanged(task: Todo)
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
        router.openDetailsScreen(task: task) { [weak self] task in
            self?.interactor.updateEditedTask(task: task)
        }
    }

    func didTapCreateNewTaskButton() {
        router.openCreateNewTaskScreen() { [weak self] task in
            self?.interactor.validateTaskID(task: task)
        }
    }
    
    func taskCompletedValueChanged(task: Todo) {
        self.interactor.updateTaskCompletion(task: task)
    }

    init(interactor: MainScreenInteractorProtocol, router: MainScreenRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
