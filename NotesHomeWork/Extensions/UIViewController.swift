//
//  ViewController.swift
//  NotesHomeWork
//
//  Created by Василий on 12.02.2022.
//

import UIKit

extension UIViewController {
    
    func addVC(_ child: UIViewController){
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func removeVC(){
        guard parent != nil else { return }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
}
