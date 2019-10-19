//
//  TableViewController.swift
//  focusStart
//
//  Created by Mikhail Sergeev on 15.10.2019.
//  Copyright © 2019 Mikhail Sergeev. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    
    let cellIdentifier="Cell"
    var selectedRow:Int?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCars.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text=arrayCars[indexPath.row].manufacturer
        cell.detailTextLabel?.text=[arrayCars[indexPath.row].model, arrayCars[indexPath.row].bodyType,arrayCars[indexPath.row].yearOfManufacture].joined(separator: " ")
        
        return cell
    }

    


    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//
//        return true
//    }
    


    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            removeCar(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }

    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // edit Car
        let edit:UIContextualAction=UIContextualAction(style: .destructive, title: "Edit", handler: {(action, view, completition) in
            completition(true)
            self.selectedRow=indexPath.row
            self.performSegue(withIdentifier: "editshow", sender: nil)
        })
        
        edit.backgroundColor = .gray
        
        // delete Car
        let delete:UIContextualAction=UIContextualAction(style: .destructive, title: "Delete", handler: { action, view, completition in
            removeCar(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completition(true)
        })
        
        
        return UISwipeActionsConfiguration(actions: [delete, edit])
    }

    
//     Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }



//    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
 

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
         
        if segue.identifier=="editshow"  {
            if let editVC=segue.destination as? EditViewController, let index=self.selectedRow {
                editVC.index=index
            }
        }
    }

        
        
    @IBAction func saveToMainViewController (segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func editToMainViewController (segue:UIStoryboardSegue) {
        
        if segue.identifier=="edit" {
            let editVC=segue.source as! EditViewController
            let newCar=Car(manufacturer: editVC.manufacturerText.text!, model: editVC.modelText.text!, yearOfManufacture: editVC.yearText.text!, bodyType: editVC.bodyText.text!)
            arrayCars.insert(newCar, at: editVC.index!)
            self.tableView.reloadData()
        }
        
    }
    
}
