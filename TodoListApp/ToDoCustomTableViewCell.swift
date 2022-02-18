//
//  ToDoCustomTableViewCell.swift
//  TodoListApp
//
//  Created by Najla on 10/01/2022.
//

import UIKit

class ToDoCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var TaskTitle: UILabel!
    @IBOutlet weak var TaskDescrption: UILabel!
    @IBOutlet weak var DueDate: UILabel!
  
    @IBOutlet weak var TaskProgressDone: UILabel!
    
  
    func setCell(t: String, d: String, n: String){
        TaskTitle.text = t
        TaskDescrption.text = n
        DueDate.text = d
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
