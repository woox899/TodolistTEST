//
//  MainScreenRouter.swift
//  ToDoList
//
//  Created by Андрей Бабкин on 26.08.2024.
//

import UIKit

protocol MainScreenRouterProtocol: AnyObject {
    func openDetailsScreen(task: Todo)
    func openCreateNewTaskScreen(completion: ((Todo) -> Void)?)
}

final class MainScreenRouter: MainScreenRouterProtocol {
    weak var viewController: MainScreenViewController?
    
    func openDetailsScreen(task: Todo) {
        let detailsVc = ToDoDetailsScreenViewBuilder.build(task: task, routes: nil)
        viewController?.present(detailsVc, animated: true)
    }

    func openCreateNewTaskScreen(completion: ((Todo) -> Void)?) {
        let detailsVc = ToDoDetailsScreenViewBuilder.build(
            task: nil,
            routes: { [weak self] routes in
                switch routes {
                case .createTask(let task):
                    completion?(task)
                    self?.viewController?.dismiss(animated: true)
                }
        })
        viewController?.present(detailsVc, animated: true)
    }
}
