//
//  MainScreenEntity.swift
//  ToDoList
//
//  Created by Андрей Бабкин on 26.08.2024.
//

import Foundation

// MARK: - Welcome
struct TodoListModel: Codable {
    var todos: [Todo]
}

// MARK: - Todo
struct Todo: Codable {
    var id: Int
    var todo: String
    var completed: Bool
    var description: String?
}

