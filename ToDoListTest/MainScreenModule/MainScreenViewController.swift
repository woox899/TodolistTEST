//
//  ViewController.swift
//  ToDoListTest
//
//  Created by Андрей Бабкин on 26.08.2024.
//

import UIKit

protocol MainScreenViewControllerProtocol: AnyObject {
    func displayFilledTasks(tasks: MainScreenEntity.MainScreenTodoList) // показать заполненные таски
}

final class MainScreenViewController: UIViewController, MainScreenViewControllerProtocol {

    var presenter: MainScreenPresenterProtocol? // ссылка на презентер
    
    var tasksArray = TodoListModel(todos: []) // датасорс таблицы

    private lazy var mainTableView: UITableView = {
        let mainTableView = UITableView(frame: view.bounds, style: .plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(MainScreenTableViewCell.self, forCellReuseIdentifier: MainScreenTableViewCell.reuseID)
        mainTableView.backgroundColor = UIColor(red: 43/255, green: 50/255, blue: 54/255, alpha: 1)
        mainTableView.separatorStyle = .none
        return mainTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoaded() // контроллер сообщает презентеру что он загрузился
    }

    func displayFilledTasks(tasks: MainScreenEntity.MainScreenTodoList) { // метод где запоняется массив
        tasksArray = tasks.list // заполнение массива
        mainTableView.reloadData() // обновление таблицы
    }
    
    private func setupUI() {
        view.addSubview(mainTableView)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "To Do List"
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addNewTask))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc func addNewTask() {
        presenter?.didTapCreateNewTaskButton() 
    }
}

extension MainScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let toDoTableViewCell = mainTableView.dequeueReusableCell(withIdentifier: MainScreenTableViewCell.reuseID, for: indexPath) as? MainScreenTableViewCell else {
            return UITableViewCell()
        }
        toDoTableViewCell.configure(tasks: tasksArray.todos[indexPath.row])
        toDoTableViewCell.selectionStyle = .none
        toDoTableViewCell.completedValueChanged = { [weak self] isCompleted in
            guard let self else { return }
            self.tasksArray.todos[indexPath.row].completed = isCompleted
            self.presenter?.taskCompletedValueChanged(task: self.tasksArray.todos[indexPath.row])
        }
        toDoTableViewCell.backgroundColor = UIColor(red: 43/255, green: 50/255, blue: 54/255, alpha: 1)
        return toDoTableViewCell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasksArray.todos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

extension MainScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didTapRow(task: tasksArray.todos[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tasksArray.todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
