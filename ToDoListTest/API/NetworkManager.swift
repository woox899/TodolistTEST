//
//  NetworkManager.swift
//  ToDoList
//
//  Created by Андрей Бабкин on 26.08.2024.
//

import UIKit
import Alamofire

class NetworkManager {
    func getTasks(complition: @escaping (Result <TodoListModel, Error>) -> Void)  {
        guard let url = URL(string: "https://dummyjson.com/todos") else { return }
        
        AF.request(url, method: .get).response { response in
            if let error = response.error {
                complition(.failure(error))
            } else {
                if let data = response.data {
                    let decoder = JSONDecoder()
                    guard let responseData = try? decoder.decode(TodoListModel.self, from: data) else {
                        return
                    }
                    complition(.success(responseData))
                } else {
                    print("")
                }
            }
        }
    }
    
    func addNewTask(task: TodoRequest, complition: @escaping (Result <Todo, Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos/add") else { return }
        
        let header = HTTPHeader(name: "Content-Type", value: "application/json")
        
        let params = ["todo" : task.todo, "completed" : task.completed, "userId" : task.userId] as [String : Any]

        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default ,headers: [header]).response { response in
            if let error = response.error {
                complition(.failure(error))
            } else {
                if let data = response.data {
                    let decoder = JSONDecoder()
                    guard let responseData = try? decoder.decode(Todo.self, from: data) else {
                        return
                    }
                    complition(.success(responseData))
                } else {
                    print("")
                }
            }
        }
        
    }
    //MARK: - updateTask
    func updateTask(task: TodoRequest, complition: @escaping (Result <Todo, Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos/1") else {
            return
        }
        
        let header = HTTPHeader(name: "Content-Type", value: "application/json")
        
        let params = ["completed" : task.completed] as [String : Any]
        
        AF.request(url, method: .put, parameters: params, encoding: JSONEncoding.default, headers: [header]).response { response in
            if let error = response.error {
                complition(.failure(error))
            } else {
                if let data = response.data {
                    let decoder = JSONDecoder()
                    guard let responseData = try? decoder.decode(Todo.self, from: data) else {
                        return
                    }
                    complition(.success(responseData))
                } else {
                    print("")
                }
            }
        }
    }
    //MARK: - deleteTask
    
    func deleteTask(complition: @escaping (Result <TodoRequestDeleted, Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos/1") else {
            return
        }
        AF.request(url, method: .delete).response { response in
            if let error = response.error {
                complition(.failure(error))
            } else {
                if let data = response.data {
                    let decoder = JSONDecoder()
                    guard let responseData = try? decoder.decode(TodoRequestDeleted.self, from: data) else {
                        return
                    }
                    complition(.success(responseData))
                } else {
                    print("")
                }
            }
        }
    }
}
