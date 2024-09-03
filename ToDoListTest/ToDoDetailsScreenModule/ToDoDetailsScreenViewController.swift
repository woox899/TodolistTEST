//
//  ToDoDetailsScreenViewController.swift
//  ToDoListTest
//
//  Created by Андрей Бабкин on 27.08.2024.
//

import UIKit
import SnapKit

protocol ToDoDetailsScreenViewControllerProtocol: AnyObject {
    func displayTaskDetails(task: TodoDetailsScreenEntity.TodoDetailsTaskModel)
    func displayNewTask()
}

final class ToDoDetailsViewController: UIViewController, ToDoDetailsScreenViewControllerProtocol {
    
    var presenter: ToDoDetailsScreenPresenterProtocol?
    
    private var todo: Todo?
    
    private var todoRequest: TodoRequest?
    
    private let taskNameLabel: UILabel = {
        let taskNameLabel = UILabel()
        taskNameLabel.text = "Task name"
        taskNameLabel.textColor = .white
        return taskNameLabel
    }()
    
    private lazy var taskNameTextView: UITextView = {
        let taskNameTextView = UITextView()
        taskNameTextView.layer.cornerRadius = 6
        taskNameTextView.font = .systemFont(ofSize: 16)
        taskNameTextView.delegate = self
        return taskNameTextView
    }()
    
    private let taskDescriptionLabel: UILabel = {
        let taskDescriptionLabel = UILabel()
        taskDescriptionLabel.text = "Task description"
        taskDescriptionLabel.textColor = .white
        return taskDescriptionLabel
    }()
    
    private lazy var taskDescriptionTextView: UITextView = {
        let taskDescriptionTextView = UITextView()
        taskDescriptionTextView.layer.cornerRadius = 6
        taskDescriptionTextView.font = .systemFont(ofSize: 14)
        taskDescriptionTextView.delegate = self
        return taskDescriptionTextView
    }()
    
    private lazy var saveChangesButton: UIButton = {
        let saveChangesButton = UIButton()
        saveChangesButton.layer.cornerRadius = 24
        saveChangesButton.setTitle("Save changes", for: .normal)
        saveChangesButton.setTitleColor(.black, for: .normal)
        saveChangesButton.backgroundColor = UIColor(red: 248/255, green: 204/255, blue: 114/255, alpha: 1)
        saveChangesButton.addTarget(self, action: #selector(saveTaskChanges), for: .touchUpInside) 
        return saveChangesButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 43/255, green: 50/255, blue: 54/255, alpha: 1)
        presenter?.viewDidLoaded()
        setupUI()
    }
    
    func displayTaskDetails(task: TodoDetailsScreenEntity.TodoDetailsTaskModel) {
        self.todo = task.todo
        taskNameTextView.text = task.todo.todo
        taskDescriptionTextView.text = "empty text"
    }
    
    func displayNewTask() {
        self.todoRequest = TodoRequest(todo: "new task", completed: false, userId: Constants.userId)
        taskNameTextView.text = todoRequest?.todo
        taskDescriptionTextView.text = "empty text"
        
    }
    
    @objc private func saveTaskChanges() {
        if let todo = self.todo {
            presenter?.saveNewTaskChanges(task: todo)
            // здесь метод сохранения таски дергать
        }
        
        if let todoRequest = self.todoRequest {
            presenter?.addNewTask(task: todoRequest)
        }
    }
    
    private func setupUI() {
        view.addSubview(taskNameTextView)
        view.addSubview(taskNameLabel)
        view.addSubview(taskDescriptionTextView)
        view.addSubview(taskDescriptionLabel)
        view.addSubview(saveChangesButton)
        
        taskNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        taskNameTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(taskNameLabel.snp.bottom).offset(10)
            make.width.equalTo(view.frame.width * 0.75)
            make.height.equalTo(80)
        }
        
        taskDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(taskNameTextView.snp.bottom).offset(50)
        }
        
        taskDescriptionTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(taskDescriptionLabel.snp.bottom).offset(10)
            make.width.equalTo(view.frame.width * 0.75)
            make.height.equalTo(200)
        }
        
        saveChangesButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(taskDescriptionTextView.snp.bottom).offset(30)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
}

extension ToDoDetailsViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == taskNameTextView {
            todo?.todo = textView.text
        }
    }
}
