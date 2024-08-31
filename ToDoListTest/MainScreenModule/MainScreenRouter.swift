//
//  MainScreenRouter.swift
//  ToDoList
//
//  Created by Андрей Бабкин on 26.08.2024.
//

import UIKit

protocol MainScreenRouterProtocol: AnyObject {
    func openDetailsScreen(task: Todo, completion: ((Todo) -> Void)?)
    func openCreateNewTaskScreen(completion: ((Todo) -> Void)?)
}

final class MainScreenRouter: MainScreenRouterProtocol {
    weak var viewController: MainScreenViewController?
    
    func openDetailsScreen(task: Todo, completion: ((Todo) -> Void)?) {
        let builder = ToDoDetailsScreenViewBuilder()
        let detailsVC = builder.build(task: task)
        builder.router?.routes = { [weak self] routes in
            switch routes {
            case .saveTaskChanges(let task):
                completion?(task)
                self?.viewController?.dismiss(animated: true)
            }
        }
        viewController?.present(detailsVC, animated: true)
    }

    func openCreateNewTaskScreen(completion: ((Todo) -> Void)?) {
        let builder = ToDoDetailsScreenViewBuilder()
        let detailsVC = builder.build(task: nil)
        builder.router?.routes = { [weak self] routes in
            switch routes {
            case .saveTaskChanges(let task):
                completion?(task)
                self?.viewController?.dismiss(animated: true)
            }
        }
        viewController?.present(detailsVC, animated: true)
    }
}
