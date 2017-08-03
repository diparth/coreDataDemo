//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Diparth Patel on 5/31/17.
//  Copyright © 2017 Diparth Patel. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var detailsField: UITextField!
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var typePicker: UIPickerView!
    
    
    var stores = [Store]()
    var itemToEdit: Item?
    var itemTypes = [ItemType]()
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        storePicker.dataSource = self
        storePicker.delegate = self
        typePicker.dataSource = self
        typePicker.delegate = self
        imagePicker = UIImagePickerController.init()
        imagePicker.delegate = self
        
        
        //setStoreData()
        //setItemTypeData()
        getStores()
        getItemTypes()
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil)
        }
        
        if itemToEdit != nil {
            self.fetchItemData()
        }
        
    }
    
    func setItemTypeData() {
        let type1 = ItemType(context: context)
        type1.type = "Electronics"
        let type2 = ItemType(context: context)
        type2.type = "Cars"
        let type3 = ItemType(context: context)
        type3.type = "Jewelry"
        let type4 = ItemType(context: context)
        type4.type = "Real Estate"
        ad.saveContext()
    }
    
    func setStoreData() {
        
        let context = ad.persistentContainer.viewContext
        
        let store = Store(context: context)
        store.name = "Best Buy"
        let store1 = Store(context: context)
        store1.name = "Walmart"
        let store2 = Store(context: context)
        store2.name = "Meserati Moters"
        let store3 = Store(context: context)
        store3.name = "Tesla Moters"
        let store4 = Store(context: context)
        store4.name = "Apple Store"
        let store5 = Store(context: context)
        store5.name = "Amazon"
        
        
        ad.saveContext()
        
    }
    
    func getStores() {
        let context = ad.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        }catch {
            print("Error: \(error)")
        }
    }
    
    func getItemTypes() {
        let fetchRequest: NSFetchRequest<ItemType> = ItemType.fetchRequest()
        
        do {
            self.itemTypes = try context.fetch(fetchRequest)
            self.typePicker.reloadAllComponents()
        }catch {
            print("Error: \(error)")
        }
    }
    
    
    //MARK: PickerView Delegate Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == storePicker {
            return stores.count
        }else if pickerView == typePicker {
            return itemTypes.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == storePicker {
            return stores[row].name
        }else if pickerView == typePicker {
            return itemTypes[row].type
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    
    @IBAction func deleteDataPressed(_ sender: UIButton) {
    
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
    
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        //let item = Item(context: ad.persistentContainer.viewContext)
        
        var item: Item!
        
        if itemToEdit == nil {
            item = Item(context: ad.persistentContainer.viewContext)
        }else {
            item = itemToEdit
        }
        
        
        let picture = Image(context: context)
        picture.image = thumbImage.image
        item.toImage = picture
        
        
        if let title = self.titleField.text {
            item.title = title
        }
        if let price = self.priceField.text {
            item.price = (price as NSString).doubleValue
        }
        if let details = self.detailsField.text {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        item.toItemType = itemTypes[typePicker.selectedRow(inComponent: 0)]
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    func fetchItemData() {
        
        if let item = itemToEdit {
            self.titleField.text = item.title
            self.priceField.text = "\(item.price)"
            self.detailsField.text = item.details
            self.thumbImage.image = item.toImage?.image as? UIImage
            if let store = itemToEdit?.toStore {
                self.storePicker.selectRow(stores.index(of: store)!, inComponent: 0, animated: true)
            }
            if let type = itemToEdit?.toItemType {
                self.typePicker.selectRow(itemTypes.index(of: type)!, inComponent: 0, animated: true)
            }
        }
    }
    
    
    //MARK: Image Picking methods
    
    @IBAction func imageButtonPressed(_ sender: UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.thumbImage.image = img
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
}




