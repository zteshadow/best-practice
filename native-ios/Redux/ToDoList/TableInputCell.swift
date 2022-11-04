//
//  TableInputCell.swift
//  ToDoList
//
//  Created by samuelsong on 2022/11/2.
//

import UIKit

protocol TableViewInputCellDelegate: AnyObject {
    func inputChanged(cell: TableViewInputCell, text: String)
}

class TableViewInputCell: UITableViewCell {
    weak var delegate: TableViewInputCellDelegate?
    @IBOutlet weak var textField: UITextField!
    @objc @IBAction func textFieldValueChanged(_ sender: UITextField) {
        delegate?.inputChanged(cell: self, text: sender.text ?? "")
    }
}
