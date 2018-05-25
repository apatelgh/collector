//
//  AddItemViewController.swift
//  Collector
//
//  Created by Anil Patel on 24/05/2018.
//  Copyright © 2018 Anil Patel. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var itemImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //    }
    
    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            itemImageView.image = chosenImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil) // once image selected, close down imagepicker
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            let item = Item(entity: Item.entity(), insertInto: context)
            
            item.title = titleTextField.text
            
            if let image = itemImageView.image {                        // first get the image
                if let imageData = UIImagePNGRepresentation(image) {    // then convert image to Data format
                    item.image = imageData
                }
            }
            
            try? context.save()
            
            navigationController?.popViewController(animated: true)
        }
    }
}
