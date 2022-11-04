//
//  ViewController.swift
//  ToDoList
//
//  Created by samuelsong on 2022/11/2.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let controller: TableViewController = UIStoryboard(name: "Table", bundle: nil)
            .instantiateViewController(withIdentifier: "tableViewController") as! TableViewController

        let presenter = ToDoListPresenterImpl(controller)
        controller.presenter = presenter
        
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: false)
    }

}

