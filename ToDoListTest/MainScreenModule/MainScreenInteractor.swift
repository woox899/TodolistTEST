//
//  MainScreenInteractor.swift
//  ToDoList
//
//  Created by Андрей Бабкин on 26.08.2024.
//

import UIKit

protocol MainScreenInteractorProtocol: AnyObject {
    func loadTasks()
    func validateTaskID(task: Todo)
    func updateEditedTask(task: Todo)
    func updateTaskCompletion(task: Todo)
}

final class MainScreenInteractor: MainScreenInteractorProtocol {

    private var tasks = TodoListModel(todos: [])

    weak var presenter: MainScreenPresenterProtocol?
    
    func loadTasks() {
        let networkManager = NetworkManager()
        networkManager.getTasks() { [weak self] tasks in
            guard let self else {
                return
            }
            switch tasks {
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
    
    func validateTaskID(task: Todo) {
        var currentTask = task
        if tasks.todos.contains(where: { currentTask.id == $0.id }) {
            currentTask.id = Int.random(in: 0...100000)
            validateTaskID(task: currentTask)
        } else {
            self.tasks.todos.insert(task, at: 0)
            // здесь обновлять базу данных
            self.presenter?.presentFilledTasks(tasks: tasks)
            
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
