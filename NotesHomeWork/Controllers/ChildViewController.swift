//
//  ChildViewController.swift
//  NotesHomeWork
//
//  Created by Василий on 12.02.2022.
//

import UIKit

class ChildViewController: UIViewController {

// MARK: - properties
    
    var tableView = UITableView()
    var tasks: [CompositeProtocol] = []

// MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print("Я загрузился!")
    }

// MARK: - action

    @objc func addTask() {
        addFolder()
    }

    @objc func backButtonTapped() {
        print("reversing child")
        removeVC()
    }

// MARK: - business logic

    private func addFolder() {
        let textController = UIAlertController(title: "Добавить задачу", message: nil, preferredStyle: .alert)
        textController.addTextField()
        textController.addTextField()
        let submitAction = UIAlertAction(title: "Готово", style: .default) { [unowned textController] _ in
            let answerName = textController.textFields![0]
            let answerDesc = textController.textFields![1]
            self.tasks.append(MainTask(name: answerName.text ?? "No name",
                                       description: answerDesc.text ?? "no description"))
            print("Appending folder \(answerName.text ?? "empty name")")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        textController.addAction(submitAction)
        present(textController, animated: true)
        print(self.tasks.count)
    }

// MARK: - UI

    private func setupUI(){
        tasks.forEach { $0.add() }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "reuseId")
        view.addSubview(tableView)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить задачу",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addTask))

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                           target: self,
                                                           action: #selector(backButtonTapped))
    }

}

// MARK: - extensions

extension ChildViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseId") as! TaskTableViewCell
        cell.configureTask(with: tasks[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }

}

extension ChildViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("connecting child")
        addVC(ChildViewController())
    }

}
