//
//  ToDoDetailsViewBuilder.swift
//  ToDoListTest
//
//  Created by Андрей Бабкин on 27.08.2024.
//

import UIKit

class ToDoDetailsScreenViewBuilder {
    weak var router: ToDoDetailsScreenRouter?
    func build(task: Todo?) -> ToDoDetailsViewController {
        let viewController = ToDoDetailsViewController()
        let interactor = ToDoDetailsScreenInteractor(task: task)
        let router = ToDoDetailsScreenRouter()
        let presenter = ToDoDetailsScreenPresenter(interactor: interactor, router: router)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        self.router = router
        return viewController
    }
}
