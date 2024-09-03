//
//  UITableViewCell.swift
//  ToDoList
//
//  Created by Андрей Бабкин on 26.08.2024.
//

import UIKit
import SnapKit

final class MainScreenTableViewCell: UITableViewCell {
    
    static let reuseID = "MainScreenTableViewCell"
    
    var tasks: Todo?
    
    var segmentControlArray = [UIImage(systemName: "checkmark"), UIImage(systemName: "xmark")]
    
    var completedValueChanged: ((Bool) -> Void)?
    
    private let backgroundViewForCell: UIView = {
        let backgroundViewForCell = UIView()
        backgroundViewForCell.layer.cornerRadius = 12
        return backgroundViewForCell
    }()

    private var taskNameLabel: UILabel = {
        let taskName = UILabel()
        taskName.numberOfLines = 3
        taskName.font = .boldSystemFont(ofSize: 16)
        taskName.adjustsFontSizeToFitWidth = true
        return taskName
    }()
    
    private let taskDescriptionLabel: UILabel = {
        let taskDescription = UILabel()
        taskDescription.font = .systemFont(ofSize: 14)
        return taskDescription
    }()
    
    private let dividingLine: UIView = {
        let dividingLine = UIView()
        dividingLine.backgroundColor = .gray
        return dividingLine
    }()
    
    private let dateOfCreationLabel: UILabel = {
        let dateOfCreationLabel = UILabel()
        dateOfCreationLabel.text = "Date of creation"
        dateOfCreationLabel.font = .systemFont(ofSize: 14)
        dateOfCreationLabel.textAlignment = .center
        return dateOfCreationLabel
    }()
    
    private let dateOfCreation: UILabel = {
        let dateOfCreation = UILabel()
        dateOfCreation.text = "11.04.2019"
        dateOfCreation.font = .systemFont(ofSize: 14)
        dateOfCreation.textAlignment = .center
        return dateOfCreation
    }()

    private lazy var statusSegmentControl: UISegmentedControl = {
        let statusSegmentControl = UISegmentedControl(items: segmentControlArray as [Any])
        statusSegmentControl.addTarget(self, action: #selector(chengeCellColor), for: .valueChanged)
        return statusSegmentControl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(tasks: Todo) {
        self.tasks = tasks
        taskNameLabel.text = tasks.todo
        taskDescriptionLabel.text = "empty text"
        
        if tasks.completed == true {
            statusSegmentControl.selectedSegmentIndex = 0
            backgroundViewForCell.backgroundColor = UIColor(red: 147/255, green: 244/255, blue: 146/255, alpha: 1)
        } else if tasks.completed == false {
            statusSegmentControl.selectedSegmentIndex = 1
            backgroundViewForCell.backgroundColor = UIColor(red: 242/255, green: 95/255, blue: 101/255, alpha: 1)
        }
    }
    
   @objc func chengeCellColor() {
        if statusSegmentControl.selectedSegmentIndex == 0 {
            completedValueChanged?(true)
        } else if statusSegmentControl.selectedSegmentIndex == 1 {
            completedValueChanged?(false)
        }
    }
    
    private func setupUI() {
        contentView.addSubview(backgroundViewForCell)
        backgroundViewForCell.addSubview(taskNameLabel)
        backgroundViewForCell.addSubview(taskDescriptionLabel)
        backgroundViewForCell.addSubview(dividingLine)
        backgroundViewForCell.addSubview(dateOfCreation)
        backgroundViewForCell.addSubview(dateOfCreationLabel)
        backgroundViewForCell.addSubview(statusSegmentControl)
        
        backgroundViewForCell.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.trailing.equalTo(contentView.snp.trailing).offset(-10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }

        taskNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(backgroundViewForCell.snp.leading).offset(10)
            make.top.equalTo(backgroundViewForCell.snp.top).offset(10)
            make.trailing.equalTo(statusSegmentControl.snp.leading).offset(-10)
            make.bottom.equalTo(taskDescriptionLabel.snp.top).offset(-10)
        }
        
        taskDescriptionLabel.snp.makeConstraints { make in
            make.leading.equalTo(backgroundViewForCell).offset(10)
            make.top.equalTo(taskNameLabel.snp.bottom).offset(15)
            make.trailing.equalTo(statusSegmentControl.snp.leading).offset(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        
        dividingLine.snp.makeConstraints { make in
            make.leading.equalTo(taskNameLabel.snp.trailing).offset(5)
            make.centerY.equalTo(backgroundViewForCell.snp.centerY)
            make.top.equalTo(backgroundViewForCell.snp.top).offset(10)
            make.bottom.equalTo(backgroundViewForCell.snp.bottom).offset(-10)
            make.width.equalTo(1)
        }
        
        statusSegmentControl.snp.makeConstraints { make in
            make.trailing.equalTo(backgroundViewForCell).offset(-10)
            make.top.equalTo(backgroundViewForCell).offset(10)
            make.leading.equalTo(taskNameLabel.snp.trailing).offset(10)
            make.bottom.equalTo(dateOfCreationLabel.snp.top).offset(-5)
            make.width.equalTo(120)
        }

        dateOfCreation.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(dateOfCreationLabel.snp.bottom)
            make.leading.equalTo(taskNameLabel.snp.trailing).offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(120)
        }
        
        dateOfCreationLabel.snp.makeConstraints { make in
            make.top.equalTo(statusSegmentControl.snp.bottom).offset(5)
            make.bottom.equalTo(dateOfCreation.snp.top)
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalTo(taskNameLabel.snp.trailing).offset(10)
            make.height.equalTo(20)
        }
    }
}
