//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Justin Honda on 8/2/20.
//  Copyright © 2020 Laguna Labs. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item(title: "Find Mike")
        itemArray.append(newItem)
        let newItem2 = Item(title: "Buy some Eggos")
        itemArray.append(newItem2)
        let newItem3 = Item(title: "Destroy Demigorgon")
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isDone ? .checkmark : .none
        return cell
    }

    // MARK: - Table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        itemArray[indexPath.row].isDone.toggle()

        if let selectedCell = tableView.cellForRow(at: indexPath) {
            selectedCell.accessoryType = itemArray[indexPath.row].isDone ? .checkmark : .none
        }
        
        self.tableView.reloadData()
        
        // animates deselection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add new items section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in

            let newItem = Item(title: (alert.textFields?.first?.text)!)
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Description"
        }
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
}
