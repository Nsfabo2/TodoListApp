//
//  ToDoTableViewDelegate.swift
//  TodoListApp
//
//  Created by Najla on 10/01/2022.
//

import Foundation
import UIKit
protocol ToDoTableViewDelegate: AnyObject{
    
    func add(by controller: AddTaskViewController, title: String, desc: String, percentage: Int, date: String, at indecPath: NSIndexPath?)
    
    func cancel(by controller: AddTaskViewController)
}
