//
//  TableViewController.swift
//  focusStart
//
//  Created by Mikhail Sergeev on 15.10.2019.
//  Copyright © 2019 Mikhail Sergeev. All rights reserved.
//


import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    // для запроса
    var arrayCars:Results<CarsRealm>!
    
    // идентификатор ячейки
    let cellIdentifier="Cell"
    
    // выбранная строка для редактирования
    // нужна для передачи в EditViewController
    var selectedRow:Int?
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // загрузка объектов из базы данных
        arrayCars=realm.objects(CarsRealm.self)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if arrayCars.count != 0 {
           return arrayCars.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let car=arrayCars[indexPath.row]
        
        cell.textLabel?.text=car.manufacturer
        cell.detailTextLabel?.text=[car.model, car.body, car.year].joined(separator: " / ")
        
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
        
//         delete Car
        let delete:UIContextualAction=UIContextualAction(style: .destructive, title: "Delete", handler: { action, view, completition in
            
            let selectedCar=self.arrayCars[indexPath.row]
            
            try! realm.write {
                realm.delete(selectedCar)
            }
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
         
        if segue.identifier=="editshow"  {
            print("сработал переход по prepare for segue")
            
            if let editVC=segue.destination as? EditViewController, let _=self.selectedRow {
                
                let car=arrayCars[selectedRow!]
                editVC.editingCar=car
                
            }
            
        }
    }
    
    @IBAction func goToMainViewController (unwindSegue: UIStoryboardSegue) {
        
    }
    
}
