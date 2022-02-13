//
//  RootFolder.swift
//  NotesHomeWork
//
//  Created by Василий on 10.02.2022.
//

import Foundation

final class RootFolder: CompositeProtocol {

    var name: String
    var description: String
    var files: [CompositeProtocol] = []

    init(name: String, description: String) {
        self.name = name
        self.description = description
    }

    func add() {
        print("\(name) opened")
        self.files.forEach { $0.add()}
    }

}
