//
//  ViewController.swift
//  NotesHomeWork
//
//  Created by Василий on 01.02.2022.
//

import UIKit

class ParentViewController: UIViewController {

// MARK: - properties

    var addButton = UIBarButtonItem()
    var tableView = UITableView()
    var tasks: [CompositeProtocol] = []

// MARK: - lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

// MARK: - action

    @objc func addTask() {
        addFolder()
    }

// MARK: - business logic

    private func addFolder() {
        let textController = UIAlertController(title: "Добавьте задачу", message: nil, preferredStyle: .alert)
        textController.addTextField()
        textController.addTextField()
        let submitAction = UIAlertAction(title: "Готово", style: .default) { [unowned textController] _ in
            let answerName = textController.textFields![0]
            let answerDesc = textController.textFields![1]
            self.tasks.append(RootFolder(name: answerName.text ?? "No name", description: answerDesc.text ?? {
                let taskNames = self.tasks.compactMap {$0.description}.joined(separator: ",")
                return "tasks \(taskNames)"
            }()))
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

    func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "reuseId")
        view.addSubview(tableView)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить задачу",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addTask))
    }

}

// MARK: - extensions

extension ParentViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseId") as! TaskTableViewCell
        cell.configureTask(with: tasks[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }

}

extension ParentViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("connecting child")
        addVC(ChildViewController())
    }

}
