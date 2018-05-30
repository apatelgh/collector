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
    var storedPhoto = displayitem()    // by default an optional is nil by its very nature
    //var photoSelected = ""
    
    @IBOutlet weak var photoSelected: UIImageView!
    @IBOutlet weak var photoSelectedDesc: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("storedPhoto.title is : \(storedPhoto.title)")
        photoSelectedDesc.text = storedPhoto.title
        
        }
    
        // photoSelected.image = UIImagePNGRepresentation(photoSelected.image!)
        //photoSelected.image = UIImage(data: photoSelected.image)

}
