//
//  TableViewController.swift
//  ToDoList
//
//  Created by samuelsong on 2022/11/2.
//

import Combine
import UIKit

let inputCellReuseId = "inputCell"
let todoCellResueId = "todoCell"

class TableViewController: UITableViewController {
    private var bags = Set<AnyCancellable>()

    var viewModel: ToDoListViewModel? {
        didSet {
            viewModel?.$enableAdd.sink { [weak self] enabled in
                self?.navigationItem.rightBarButtonItem?.isEnabled = enabled
            }.store(in: &bags)

            viewModel?.$todos.sink { [weak self] list in
                self?.todos = list
                self?.tableView.reloadData()
            }.store(in: &bags)

            viewModel?.$title.sink { [weak self] title in
                self?.title = title
            }.store(in: &bags)
        }
    }

    enum Section: Int {
        case input = 0, todos, max
    }
    
    var todos: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.load()
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
        viewModel?.remove(at: indexPath.row)
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        viewModel?.add()

        let inputIndexPath = IndexPath(row: 0, section: Section.input.rawValue)
        guard let inputCell = tableView.cellForRow(at: inputIndexPath) as? TableViewInputCell else {
            return
        }

        inputCell.textField.text = ""
    }
}

extension TableViewController: TableViewInputCellDelegate {
    func inputChanged(cell: TableViewInputCell, text: String) {
        viewModel?.text = text
    }
}
