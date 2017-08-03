//
//  MainVC.swift
//  DreamLister
//
//  Created by Diparth Patel on 5/28/17.
//  Copyright © 2017 Diparth Patel. All rights reserved.
//

import UIKit
import CoreData



class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segments: UISegmentedControl!
    
    
    var FRController: NSFetchedResultsController<Item>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        print("Value ====> \(23/180*Double.pi)")
        
       // generateTestData()
        
        attemptfetch()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        attemptfetch()
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemDetailsVC" {
            if let destination = segue.destination as? ItemDetailsVC {
                if let item = sender as? Item {
                    destination.itemToEdit = item
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let objects = FRController.fetchedObjects , objects.count > 0 {
            let item = objects[indexPath.row]
            performSegue(withIdentifier: "ItemDetailsVC", sender: item)
        }
    }
    
    func configureCell(cell: ItemCell, indexPath: IndexPath) {
        
        let item = FRController.object(at: indexPath) 
        cell.configureCell(item: item)
        
    }
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        attemptfetch()
        tableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = FRController.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = FRController.sections {
            let sectionsInfo = sections[section]
            return sectionsInfo.numberOfObjects
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func attemptfetch() {
    
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        let dateSort = NSSortDescriptor.init(key: "created", ascending: false)
        let priceSort = NSSortDescriptor.init(key: "price", ascending: true)
        let titleSort = NSSortDescriptor.init(key: "title", ascending: true)
        
        if segments.selectedSegmentIndex == 0 {
            fetchRequest.sortDescriptors = [dateSort]
        }else if segments.selectedSegmentIndex == 1 {
            fetchRequest.sortDescriptors = [priceSort]
        }else if segments.selectedSegmentIndex == 2 {
            fetchRequest.sortDescriptors = [titleSort]
        }
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: ad.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        self.FRController = controller
        do {
            try controller.performFetch()
        }catch {
            let error = error as Error
            print("Error ====>  \(error)")
        }
        
    }
    

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
        
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                //Update cell data.
                configureCell(cell: cell, indexPath: indexPath)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
        
    }
    
    
    func generateTestData() {
        
        let context = ad.persistentContainer.viewContext
        
        let item = Item(context: context)
        item.title = "MacBook Pro"
        item.price = 3000
        item.details = "I want to buy MacBook!"
        
        let item2 = Item(context: context)
        item2.title = "Nikkon DSLR"
        item2.price = 2000
        item2.details = "I want to buy Nikkon DSLR!"
        
        let item3 = Item(context: context)
        item3.title = "Meserati Class S"
        item3.price = 110000
        item3.details = "I want to buy Meserati!"
        
        ad.saveContext()
    }
    
}









