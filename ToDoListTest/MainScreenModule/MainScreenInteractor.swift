//
//  MainScreenInteractor.swift
//  ToDoList
//
//  Created by Андрей Бабкин on 26.08.2024.
//

import UIKit

protocol MainScreenInteractorProtocol: AnyObject {
    func loadTasks()
}

final class MainScreenInteractor: MainScreenInteractorProtocol {

    weak var presenter: MainScreenPresenterProtocol?
    
    func loadTasks() {
        let networkManager = NetworkManager()
        networkManager.getTasks() { tasks in
            switch tasks {
            case .success(let tasks):
                self.presenter?.presentFilledTasks(tasks: tasks)
            case .failure(let error):
                self.presenter?.presentFilledTasks(tasks: TodoListModel(todos: []))
                print(error.localizedDescription)
            }
        }
    }
    
    
}
