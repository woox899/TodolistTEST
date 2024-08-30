//
//  ToDoDetailsViewBuilder.swift
//  ToDoListTest
//
//  Created by Андрей Бабкин on 27.08.2024.
//

import UIKit

enum ToDoDetailsScreenViewBuilderRoutes {
    case createTask(Todo)
}

class ToDoDetailsScreenViewBuilder {
    static func build(task: Todo?, routes: ((ToDoDetailsScreenViewBuilderRoutes) -> Void)?) -> ToDoDetailsViewController {
        let viewController = ToDoDetailsViewController()
        let interactor = ToDoDetailsScreenInteractor(task: task)
        let router = ToDoDetailsScreenRouter()
        let presenter = ToDoDetailsScreenPresenter(interactor: interactor, router: router)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        interactor.presenter = presenter
        router.viewController = viewController
      
        return viewController
    }
}
