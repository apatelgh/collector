//
//  ItemsTableViewController.swift
//  Collector
//
//  Created by Anil Patel on 24/05/2018.
//  Copyright © 2018 Anil Patel. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController {

    var items : [Item] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        getItems()
   }
    
    override func viewWillAppear(_ animated: Bool) {
        getItems()
    }

    func getItems() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        
            if let coreDataStuff = try? context.fetch(Item.fetchRequest()) as? [Item] {
                if let coreDataItems = coreDataStuff {
                    items = coreDataItems
                    tableView.reloadData()
                }
            }
        }
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print("Call from tableView numberOfRowsInSection")
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        // print("Call from tableView CellForRowAt")
        
        // get current row data
        let currentitem = items[indexPath.row]
        
        cell.textLabel?.text = currentitem.title
        
        if let imageData = currentitem.image {
            cell.imageView?.image = UIImage(data: imageData) // to convert image data back as image before displaying
        }
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            print("Delete!")

            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {

                let currentitem = items[indexPath.row]
                context.delete(currentitem)
                getItems()
            }
        }
    }

   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Photo Selected!")
        
        let currentitem = items[indexPath.row]
        performSegue(withIdentifier: "ourSegue", sender: currentitem)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let addItemVC = segue.destination as? AddItemViewController {
            addItemVC.previousVC = self
        }

        if let displayPhotoVC = segue.destination as? DisplayPhotoViewController {
            print("dislayPhotoVC Segue called")
            
            if let currentitem = sender as? Item {
                print("currentItem.title is : \(String(describing: currentitem.title))")
                displayPhotoVC.photoSelectedDesc.text = currentitem.title
                displayPhotoVC.previousVC = self
            }
        }
    }
    
}
