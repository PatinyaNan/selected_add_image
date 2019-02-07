//
//  AddEditVC.swift
//  Co-Grocery-Image
//
//  Created by Admin on 5/2/2562 BE.
//  Copyright © 2562 Admin. All rights reserved.
//

import UIKit
import CoreData

class AddEditVC: UIViewController, NSFetchedResultsControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var item : Item? = nil
    
    
    @IBOutlet weak var itemName: UITextField!
    
    
    @IBOutlet weak var itemNote: UITextField!
    
    @IBOutlet weak var itemQty: UITextField!
    
    @IBOutlet weak var imageHolder: UIImageView!
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if item != nil {
            itemName.text = item?.name
            itemNote.text = item?.note
            itemQty.text = item?.qty
            imageHolder.image = UIImage(data: (item?.imaage)! as Data)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        pickerController.allowsEditing = true
        
        self.present(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func addImageFromCamera(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerController.SourceType.camera
        pickerController.allowsEditing = true
        
        self.present(pickerController, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismiss(animated: true, completion: nil)
        
        self.imageHolder.image = image
    }
    
    
    @IBAction func saveTapped(_ sender: Any) {
        if item != nil {
            editItem()
        } else {
            createNewItem()
        }
        dismissVC()
    }
    
    func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
    
    func createNewItem(){
        let entityDescription = NSEntityDescription.entity(forEntityName: "Item", in: moc)
        
        let item = Item(entity: entityDescription!, insertInto: moc)
        
        item.name = itemName.text
        item.note = itemNote.text
        item.qty = itemQty.text
        item.imaage = imageHolder.image!.pngData()! as? NSData
        
        do {
            try moc.save()
        } catch {
            return
        }
        
    }
    
    func editItem() {
        
        item?.name = itemName.text
        item?.note = itemNote.text
        item?.qty = itemQty.text
        item!.imaage = imageHolder.image!.pngData()! as? NSData
        
        do {
            try moc.save()
        } catch {
            return
        }
        
    }
    
}
