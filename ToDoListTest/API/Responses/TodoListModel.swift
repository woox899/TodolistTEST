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
    var userId: Int?
//    var description: String?
}

struct TodoRequest: Codable {
//    let id: Int?
    let todo: String
    let completed: Bool
    let userId: Int
}

//MARK: - модель для удаления
struct TodoRequestDeleted: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
    let isDeleted: Bool
    let deletedOn: String
}
