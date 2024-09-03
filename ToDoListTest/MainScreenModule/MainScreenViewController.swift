//
//  ViewController.swift
//  ToDoListTest
//
//  Created by Андрей Бабкин on 26.08.2024.
//

import UIKit

protocol MainScreenViewControllerProtocol: AnyObject {
    func displayFilledTasks(tasks: MainScreenEntity.MainScreenTodoList)
    func deleteTask()
}

final class MainScreenViewController: UIViewController, MainScreenViewControllerProtocol {

    var presenter: MainScreenPresenterProtocol?
    
    var tasksArray = TodoListModel(todos: [])

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
        presenter?.viewDidLoaded()
    }

    func displayFilledTasks(tasks: MainScreenEntity.MainScreenTodoList) {
        tasksArray = tasks.list
        mainTableView.reloadData()
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
    
    func deleteTask() {
        presenter?.deleteTask()
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
            deleteTask()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            //MARK: - нужно ли релоадить дату таблицы ?
            tableView.reloadData()
        }
    }
}
