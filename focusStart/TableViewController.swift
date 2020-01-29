import UIKit
import CoreData

class TableViewController: UITableViewController {

    var context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrayCars:[Cars]=[]
    let cellIdentifier="Cell"
    var selectedRow:Int?
    
    func getDefaultCars() {
        // если баз данных пустая, грузим в нее три автомобиля из файла defaultCars
        let fetchRequest:NSFetchRequest<Cars>=Cars.fetchRequest()
        fetchRequest.predicate=NSPredicate(format: "manufacturer != nil")
        
        var items:Int=0
        do {
            let count=try context.count(for: fetchRequest)
            items=count
        } catch {
            print(error.localizedDescription)
        }
        guard items == 0 else {
            return
        }
        let pathToDefaultCars=Bundle.main.path(forResource: "defaultCars", ofType: "plist")!
        let carInfo=NSDictionary(contentsOfFile: pathToDefaultCars)!
        let arrayOfDic=carInfo["cars"]! as! [[String:String]]
        for dictionary in arrayOfDic {
            let entity=NSEntityDescription.entity(forEntityName: "Cars", in: context)
            let object=NSManagedObject(entity: entity!, insertInto: context) as! Cars
            object.manufacturer = dictionary["manufacturer"]!
            object.model = dictionary["model"]!
            object.body = dictionary["body"]!
            object.year = dictionary["year"]!
            
        }
    }
    
    func loadingFromCoreData() {
        let fetchRequest:NSFetchRequest<Cars>=Cars.fetchRequest()
        do {
            arrayCars = try context.fetch(fetchRequest)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDefaultCars()
        loadingFromCoreData()
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
        cell.textLabel?.text=car.manufacturer!
        cell.detailTextLabel?.text=[car.model!, car.body!, car.year!].joined(separator: " / ")
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
        
//        edit Car
        let edit:UIContextualAction=UIContextualAction(style: .destructive, title: "Edit", handler: {action, view, completition in
            completition(true)
            self.selectedRow=indexPath.row
            self.performSegue(withIdentifier: "editshow", sender: nil)
        })
        edit.backgroundColor = .gray
//        delete Car
        let delete:UIContextualAction=UIContextualAction(style: .destructive, title: "Delete", handler: { action, view, completition in
            let selectedCar=self.arrayCars[indexPath.row]
            self.context.delete(selectedCar)
            do {
                try self.context.save()
                self.loadingFromCoreData()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } catch  {
                print("Не удалось сохранить констекст \(error.localizedDescription)")
            }
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
            if let editVC=segue.destination as? EditViewController, let _=self.selectedRow {
                let car=arrayCars[selectedRow!]
//                editVC.editingCar=car
            }
            
        }
    }
    
    @IBAction func goToMainViewController (unwindSegue: UIStoryboardSegue) {
        
    }
    
}
