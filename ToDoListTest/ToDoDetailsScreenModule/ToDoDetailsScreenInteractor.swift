//
//  ToDoDetailsInteractor.swift
//  ToDoListTest
//
//  Created by Андрей Бабкин on 27.08.2024.
//

import UIKit

protocol ToDoDetailsScreenInteractorProtocol: AnyObject {
    func viewDidLoaded()
}

class ToDoDetailsScreenInteractor: ToDoDetailsScreenInteractorProtocol {

    weak var presenter: ToDoDetailsScreenPresenterProtocol?
    
    let task: Todo?
    
    init(task: Todo?) {
        self.task = task
    }

    func viewDidLoaded() {
        if let task = task {
            presenter?.presentTaskDetails(task: task)
        } else {
            presenter?.presentNewTask()
        }
    }
}
