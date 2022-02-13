//
//  TaskTableViewCell.swift
//  NotesHomeWork
//
//  Created by Василий on 12.02.2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    var nameLabel = UILabel()
    var descriptionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "reuseId")
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureTask(with task: CompositeProtocol) {
        nameLabel.text = task.name
        descriptionLabel.text = task.description
    }

    func setupUI(){
        [nameLabel, descriptionLabel].forEach{$0.translatesAutoresizingMaskIntoConstraints = false}
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            descriptionLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 15)
        ])
    }

}

