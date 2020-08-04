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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
    
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
        
        saveItem()
        
        // animates deselection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add new items section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add Item", style: .default) { (action) in

            let newItem = Item(title: (alert.textFields?.first?.text)!)
            
            self.itemArray.append(newItem)
            
            self.saveItem()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Description"
        }
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func saveItem() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array: ", error)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func loadItems() {
        let decoder = PropertyListDecoder()
        
        do {
            if let data = try? Data(contentsOf: dataFilePath!) {
                itemArray = try decoder.decode([Item].self, from: data)
            }
        } catch {
            print("Error ecoding item array:", error)
        }
    }
}
