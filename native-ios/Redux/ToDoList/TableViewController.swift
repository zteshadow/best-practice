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
    var store: Store<State, Action, Command>? {
        didSet {
            store?.subscribe() { [weak self] preState, state, cmd in
                guard let self = self else { return }

                if let cmd = cmd {
                    if cmd == .load {
                        ToDoStore.shared.getToDoItems { [weak self] list in
                            self?.store?.dispatch(action: .addItems(items: list))
                        }
                    }
                    return
                }

                if preState == nil || preState!.todos != state.todos {
                    self.todos = state.todos
                    self.title = state.title
                    self.tableView.reloadData()
                }

                if preState == nil || preState!.text != state.text {
                    let isItemLengthEnough = state.text.count > 3
                    self.navigationItem.rightBarButtonItem?.isEnabled = isItemLengthEnough

                    let inputIndexPath = IndexPath(row: 0, section: Section.input.rawValue)
                    let inputCell = self.tableView.cellForRow(at: inputIndexPath) as? TableViewInputCell
                    inputCell?.textField.text = state.text
                }
            }
        }
    }

    enum Section: Int {
        case input = 0, todos, max
    }
    
    var todos: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store?.dispatch(action: .load)
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
        store?.dispatch(action: .remove(index: indexPath.row))
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        store?.dispatch(action: .add)

        let inputIndexPath = IndexPath(row: 0, section: Section.input.rawValue)
        guard let inputCell = tableView.cellForRow(at: inputIndexPath) as? TableViewInputCell else {
            return
        }

        inputCell.textField.text = ""
    }
}

extension TableViewController: TableViewInputCellDelegate {
    func inputChanged(cell: TableViewInputCell, text: String) {
        store?.dispatch(action: .updateText(text: text))
    }
}
