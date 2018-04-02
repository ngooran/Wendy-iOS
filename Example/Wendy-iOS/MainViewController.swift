//
//  ViewController.swift
//  Wendy-iOS
//
//  Created by Levi Bostian on 03/26/2018.
//  Copyright (c) 2018 Levi Bostian. All rights reserved.
//

import UIKit
import SnapKit
import Wendy

class MainViewController: UIViewController {

    fileprivate var didSetupConstraints = false

    fileprivate let dataTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "data id"
        view.borderStyle = UITextBorderStyle.line
        return view
    }()

    fileprivate let addTaskButton: UIButton = {
        let view = UIButton()
        view.setTitle("Add task", for: UIControlState.normal)
        view.setTitleColor(UIColor.blue, for: .normal)
        return view
    }()

    fileprivate let runAllTasksButton: UIButton = {
        let view = UIButton()
        view.setTitle("Run all tasks", for: UIControlState.normal)
        view.setTitleColor(UIColor.blue, for: .normal)
        return view
    }()

    fileprivate let buttonsStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .leading
        view.distribution = .fill
        view.axis = .horizontal
        return view
    }()

    fileprivate let textFieldStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .leading
        view.distribution = .fillEqually
        view.axis = .vertical
        return view
    }()

    fileprivate let pendingTaskTableView: UITableView = {
        let view = UITableView()
        return view
    }()

    fileprivate var wendyPendingTasks: [PendingTask] = [] {
        didSet {
            self.pendingTaskTableView.reloadData()
        }
    }

    fileprivate func populateWendyPendingTasks() {
        self.wendyPendingTasks = PendingTasks.sharedInstance.getAllTasks()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        WendyConfig.addTaskRunnerListener(self)

        self.textFieldStackView.addArrangedSubview(dataTextField)

        self.buttonsStackView.addArrangedSubview(addTaskButton)
        self.buttonsStackView.addArrangedSubview(runAllTasksButton)
        self.textFieldStackView.addArrangedSubview(buttonsStackView)

        self.view.addSubview(textFieldStackView)
        self.view.addSubview(pendingTaskTableView)
        self.view.backgroundColor = UIColor.white

        self.setupview()

        self.view.setNeedsUpdateConstraints()
    }

    fileprivate func setupview() {
        self.addTaskButton.addTarget(self, action: #selector(MainViewController.addTaskButtonPressed(_:)), for: .touchUpInside)
        self.runAllTasksButton.addTarget(self, action: #selector(MainViewController.runAllTasksButtonPressed(_:)), for: .touchUpInside)

        self.pendingTaskTableView.delegate = self
        self.pendingTaskTableView.dataSource = self
        self.pendingTaskTableView.register(PendingTaskTableViewCell.self, forCellReuseIdentifier: String(describing: PendingTaskTableViewCell.self))
        self.populateWendyPendingTasks()
    }

    @objc func runAllTasksButtonPressed(_ sender: Any) {
//        PendingTasks.sharedInstance.runTasks()
        let taskId1 = try! PendingTasks.sharedInstance.addTask(AddGroceryListItemPendingTask(groceryListItemName: "task1"))
        let taskId2 = try! PendingTasks.sharedInstance.addTask(AddGroceryListItemPendingTask(groceryListItemName: "task2"))
        let taskId3 = try! PendingTasks.sharedInstance.addTask(AddGroceryListItemPendingTask(groceryListItemName: "task3"))

        print("running task from VC: \(taskId1)")
        PendingTasks.sharedInstance.runTask(taskId1)
        print("running task from VC: \(taskId2)")
        PendingTasks.sharedInstance.runTask(taskId2)
        print("running task from VC: \(taskId3)")
        DispatchQueue.global(qos: .background).async {
            PendingTasks.sharedInstance.runTask(taskId3)
        }
    }

    @objc func addTaskButtonPressed(_ sender: Any) {
        guard let dataTextEntered = self.dataTextField.text, dataTextEntered.count > 0 else {
            let alert = UIAlertController(title: "Enter text for data id", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel) { action in })
            self.present(alert, animated: true, completion: nil)
            return
        }

        try! _ = PendingTasks.sharedInstance.addTask(AddGroceryListItemPendingTask(groceryListItemName: dataTextEntered))
    }

    override func updateViewConstraints() {
        if !didSetupConstraints {
            didSetupConstraints = true

            self.buttonsStackView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.dataTextField.snp.bottom)
                make.width.equalToSuperview()
            })
            self.textFieldStackView.snp.makeConstraints({ (make) in
                make.width.equalToSuperview().offset(-40)
                make.centerX.equalToSuperview()
                if #available(iOS 11.0, *) {
                    make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                } else {
                    make.top.equalToSuperview()
                }
            })
            self.dataTextField.snp.makeConstraints({ (make) in
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.top.equalToSuperview()
            })
            self.pendingTaskTableView.snp.makeConstraints({ (make) in
                make.top.equalTo(self.textFieldStackView.snp.bottom)
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                if #available(iOS 11.0, *) {
                    make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
                } else {
                    make.bottom.equalToSuperview()
                }
            })
        }
        super.updateViewConstraints()
    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wendyPendingTasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PendingTaskTableViewCell.self), for: indexPath) as! PendingTaskTableViewCell
        let item = self.wendyPendingTasks[indexPath.row]
        cell.populateCell(item, position: indexPath.row)
        return cell
    }

}

extension MainViewController: TaskRunnerListener {

    func taskSkipped(_ task: PendingTask, reason: ReasonPendingTaskSkipped) {
        self.populateWendyPendingTasks()
    }

    func taskComplete(_ task: PendingTask, successful: Bool) {
        self.populateWendyPendingTasks()
    }

    func runningTask(_ task: PendingTask) {
        self.populateWendyPendingTasks()
    }

    func newTaskAdded(_ task: PendingTask) {
        self.populateWendyPendingTasks()
    }

}

