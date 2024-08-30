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
//    let total, skip, limit: Int?
}

// MARK: - Todo
struct Todo: Codable {
    let id: Int
    let todo: String
    let completed: Bool
}

