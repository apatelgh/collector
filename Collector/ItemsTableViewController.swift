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
    let selectedItem = displayItem() // instantiate DisplayItem object to use for storage of selected item

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
        
        let currentItem = items[indexPath.row]
//        print("Photo Selected! : \(currentItem.title)")

        // set Selected Items obejct properties to those of the currently selected item
        if let selectedItemTitle = currentItem.title {
            selectedItem.title = selectedItemTitle
        }

        if let selectedItemImage = currentItem.image {      //unwrapping and conversion of image data types
            if let selectedImageFromData = UIImage(data: selectedItemImage) {
//                print("Image converted from Data to Image")
                selectedItem.image = selectedImageFromData
            }
        }
        
        // call the segue function to invoke the display photo view controller
        performSegue(withIdentifier: "ourSegue", sender: selectedItem)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let addItemVC = segue.destination as? AddItemViewController {
            addItemVC.previousVC = self
        }

        if let displayPhotoVC = segue.destination as? DisplayPhotoViewController {
//            print("displayPhotoVC Segue called")
            
            if let currentItem = sender as? displayItem {
                displayPhotoVC.selectedItem = currentItem  //set the display photo view controller properties to currently selected
                displayPhotoVC.previousVC = self
            }
        }
    }
    
}
