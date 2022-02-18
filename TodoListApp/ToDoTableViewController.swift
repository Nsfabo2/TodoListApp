//
//  ViewController.swift
//  TodoListApp
//
/*
 Create an app that keeps track of items to do. It should have a field for title, notes, and due-date.  When the user selects the cell, it should toggle the completion of the item (shown with checkmark).
 EVERYTHING SHOULD BE PERSISTENT.
 */
//

import UIKit
import CoreData

class ToDoTableViewController: UITableViewController, ToDoTableViewDelegate {
    
    let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var todoList = [TodoListApp]()
    
    func fetchAllTasks(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoListApp")
        
        do{
            let result = try manageObjectContext.fetch(request)
            todoList = result as! [TodoListApp]
        }catch{
            print("\(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchAllTasks()
    }
    
    //for delegate
    func add(by controller: AddTaskViewController, title: String, desc: String, percentage: Int, date: String, at indecPath: NSIndexPath?) {
        if let ip = indecPath{
            let task = todoList[ip.row]
            task.todoPercentage = Int16(percentage)
            task.todoDate = date
            task.todoTitle = title
            task.todoDescrption = desc
        }else{
            let task = NSEntityDescription.insertNewObject(forEntityName: "TodoListApp", into: manageObjectContext) as! TodoListApp
            task.todoDate = date
            task.todoTitle = title
            task.todoDescrption = desc
            task.todoPercentage = Int16(percentage)
            todoList.append(task)
        }
        
        do{
            try manageObjectContext.save()
        }catch {
            print("\(error)")
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func cancel(by controller: AddTaskViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem{
            let navigationController = segue.destination as! UINavigationController
            let addViewController = navigationController.topViewController as! AddTaskViewController
            addViewController.delegate = self
        }
        else if sender is NSIndexPath{
            let navigationController = segue.destination as! UINavigationController
            let addViewController = navigationController.topViewController as! AddTaskViewController
            addViewController.delegate = self
            
            let indexPath = sender as! NSIndexPath
            addViewController.n = todoList[indexPath.row].todoDescrption
            addViewController.t = todoList[indexPath.row].todoTitle
            addViewController.d = todoList[indexPath.row].todoDate
            addViewController.p = Int(todoList[indexPath.row].todoPercentage)
            addViewController.indexPath = indexPath
        }
    }

    
    //for table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCustomTableViewCell
        
        cell.setCell(t: todoList[indexPath.row].todoTitle!, d: todoList[indexPath.row].todoDate!, n: todoList[indexPath.row].todoDescrption!)
        
        if todoList[indexPath.row].todoPercentage == 100{
            cell.TaskProgressDone.isHidden = false
        }
        else{
            cell.TaskProgressDone.isHidden = true
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AddTask", sender: indexPath)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = todoList[indexPath.row]
        manageObjectContext.delete(item)
        do{
            try manageObjectContext.save()
        }catch{
            print("\(error)")
        }
        todoList.remove(at: indexPath.row)
        tableView.reloadData()
        
    }

}//end class
