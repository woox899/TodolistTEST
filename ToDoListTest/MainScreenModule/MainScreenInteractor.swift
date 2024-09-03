//
//  MainScreenInteractor.swift
//  ToDoList
//
//  Created by Андрей Бабкин on 26.08.2024.
//

import UIKit

protocol MainScreenInteractorProtocol: AnyObject {
    func loadTasks()
    func addNewTask(task: TodoRequest)
    func updateEditedTask(task: Todo)
    func updateTaskCompletion(task: Todo)
    func deleteTask()
}

final class MainScreenInteractor: MainScreenInteractorProtocol {

    private var tasks = TodoListModel(todos: [])

    weak var presenter: MainScreenPresenterProtocol?
    
    let networkManager = NetworkManager()

    func loadTasks() {
        networkManager.getTasks() { [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case .success(let tasks):
                    self.tasks = tasks
                    self.presenter?.presentFilledTasks(tasks: tasks)
                // здесь обновлять базу
            case .failure(let error):
                self.presenter?.presentFilledTasks(tasks: self.tasks)
                print(error.localizedDescription)
            }
        }
    }
    
    func addNewTask(task: TodoRequest) {
        networkManager.addNewTask(task: task) { [weak self] result in
            guard let self = self else {
                return
            }
                switch result {
                case .success(let task):
                    self.tasks.todos.insert(task, at: 0)
                    self.presenter?.presentFilledTasks(tasks: self.tasks)
                    // обновить базу
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
        //        var currentTask = task
        //        if tasks.todos.contains(where: { currentTask.id == $0.id }) {
        //            currentTask.id = Int.random(in: 0...10000)
        //            addNewTask(task: currentTask)
        //        } else {
        //            self.tasks.todos.insert(task, at: 0)
        // здесь обновлять базу данных
        //            self.presenter?.presentFilledTasks(tasks: tasks)
//        }
    }
    
    // MARK: - мотод для удаления
    
    func deleteTask() {
        networkManager.deleteTask() { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let task):
                print(task)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateEditedTask(task: Todo) {
        self.tasks.todos.removeAll(where: { $0.id == task.id })
        self.tasks.todos.insert(task, at: 0)
        self.presenter?.presentFilledTasks(tasks: tasks)
        // здесь обновлять базу данных
    }
    
    func updateTaskCompletion(task: Todo) {
        if let index = self.tasks.todos.firstIndex(where: { $0.id == task.id }) {
            self.tasks.todos[index] = task
            self.presenter?.presentFilledTasks(tasks: tasks)
            // здесь обновлять базу данных
        }
    }
}
