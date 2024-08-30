//
//  MainScreenEntity.swift
//  ToDoListTest
//
//  Created by Андрей Бабкин on 29.08.2024.
//

import Foundation

enum MainScreenEntity {
    struct MainScreenTodoList {
        let list: TodoListModel
    }

    struct MainScreenNewTask {
        let task: Todo
    }
}
