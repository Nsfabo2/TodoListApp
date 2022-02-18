//
//  AddTaskViewController.swift
//  TodoListApp
//
//  Created by Najla on 10/01/2022.
//

import UIKit

class AddTaskViewController: UIViewController {
    //outlets
    @IBOutlet weak var TitleLabel: UITextField!
    @IBOutlet weak var DescrptionTextField: UITextField!
    @IBOutlet weak var TaskDueDate: UIDatePicker!
    @IBOutlet weak var ProgressPercentage: UISlider!
    @IBOutlet weak var PercentageLabel: UILabel!
    //delegate
    weak var delegate: ToDoTableViewDelegate?
    //attrbuites
    var indexPath: NSIndexPath?
    var t: String?
    var n: String?
    var p: Int?
    var d: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TitleLabel.text = t
        DescrptionTextField.text = n
        
        if let perc = p {
            PercentageLabel.text = "\(p!)%"
            ProgressPercentage.value = Float(perc)
        }
        else{
            PercentageLabel.text = "0%"
            ProgressPercentage.value = 0
        }
    }//end func
    
    //actions :
    //item bar buttons
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.cancel(by: self)
    }
    @IBAction func save(_ sender: UIBarButtonItem) {
        let formatter = DateFormatter()
        formatter.calendar = TaskDueDate.calendar
        formatter.dateFormat = "MM/dd/yyyy"
        
        guard let title = TitleLabel.text else { return }
        guard let note = DescrptionTextField.text else { return }
        
        delegate?.add(by: self, title: title, desc: note, percentage: Int(ProgressPercentage.value), date: formatter.string(from: TaskDueDate.date), at: indexPath)
    }
    //date and percentage slider
    @IBAction func DatePickerClicked(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.calendar = TaskDueDate.calendar
        formatter.dateFormat = "MM/dd/yyyy"
        PercentageLabel.text = "\(formatter.string(from: sender.date))"
    }
    
    @IBAction func ProgressSliderMoved(_ sender: Any) {
        PercentageLabel.text = "\(Int(ProgressPercentage.value))%"
    }
    
}
