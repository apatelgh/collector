//
//  DisplayPhotoViewController.swift
//  Collector
//
//  Created by Anil Patel on 29/05/2018.
//  Copyright © 2018 Anil Patel. All rights reserved.
//

import UIKit

class DisplayPhotoViewController: UIViewController {

    var previousVC = ItemsTableViewController()
    var selectedItem = displayItem()    // create instance of a DisplayItem to store the selected item
    
    @IBOutlet weak var photoSelected: UIImageView!
    @IBOutlet weak var photoSelectedDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // assign selected item object's property values to display view controller page
        photoSelectedDesc.text = selectedItem.title
        photoSelected.image = selectedItem.image
    }
    
}
