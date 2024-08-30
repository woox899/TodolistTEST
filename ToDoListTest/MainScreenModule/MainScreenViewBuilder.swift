//
//  MainScreenViewBuilder.swift
//  ToDoList
//
//  Created by Андрей Бабкин on 27.08.2024.
//

import UIKit

class MainScreenViewBuilder {
    static func build() -> MainScreenViewController {
        let interactor = MainScreenInteractor()
        let router = MainScreenRouter()
        let presenter = MainScreenPresenter(interactor: interactor, router: router)
        let viewController = MainScreenViewController()
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        interactor.presenter = presenter
        router.viewController = viewController
        
        return viewController
    }
}
