//
//  TableViewController.swift
//  ToDoList
//
//  Created by samuelsong on 2022/11/2.
//

import UIKit

let inputCellReuseId = "inputCell"
let todoCellResueId = "todoCell"

class TableViewController: UITableViewController {
    var presenter: ToDoListPresenter?

    enum Section: Int {
        case input = 0, todos, max
    }
    
    var todos: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.load()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.max.rawValue
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            fatalError()
        }
        switch section {
        case .input: return 1
        case .todos: return todos.count
        case .max: fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError()
        }
        
        switch section {
        case .input:
            let cell = tableView.dequeueReusableCell(withIdentifier: inputCellReuseId, for: indexPath) as! TableViewInputCell
            cell.delegate = self
            return cell
        case .todos:
            let cell = tableView.dequeueReusableCell(withIdentifier: todoCellResueId, for: indexPath)
            cell.textLabel?.text = todos[indexPath.row]
            return cell
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == Section.todos.rawValue else {
            return
        }
        presenter?.remove(at: indexPath.row)
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        presenter?.add()
        let inputIndexPath = IndexPath(row: 0, section: Section.input.rawValue)
        guard let inputCell = tableView.cellForRow(at: inputIndexPath) as? TableViewInputCell else {
            return
        }

        inputCell.textField.text = ""
    }
}

extension TableViewController: TableViewInputCellDelegate {
    func inputChanged(cell: TableViewInputCell, text: String) {
        presenter?.edit(text)
    }
}

extension TableViewController: ToDoListView {
    func update(list: [String], title: String) {
        self.title = title
        self.todos = list
        tableView.reloadData()
    }

    func enableAdd(_ enable: Bool) {
        navigationItem.rightBarButtonItem?.isEnabled = enable
    }
}
