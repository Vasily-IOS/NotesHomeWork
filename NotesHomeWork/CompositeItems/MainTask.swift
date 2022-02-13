//
//  MainLeaf.swift
//  NotesHomeWork
//
//  Created by Василий on 12.02.2022.
//

import UIKit

class MainTask: CompositeProtocol {

    var name: String
    var description: String

    init(name: String, description: String) {
        self.name = name
        self.description = description
    }

    func add() {}

}
