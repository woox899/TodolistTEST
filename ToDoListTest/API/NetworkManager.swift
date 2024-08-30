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
                        print(response)
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
