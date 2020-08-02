//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Justin Honda on 8/2/20.
//  Copyright © 2020 Laguna Labs. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        if let selectedCell = tableView.cellForRow(at: indexPath) {
            if selectedCell.accessoryType == .checkmark {
                selectedCell.accessoryType = .none
            } else {
                selectedCell.accessoryType = .checkmark
            }
        }
    }
}
