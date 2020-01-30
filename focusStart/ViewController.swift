import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var manufacturerText: UITextField!
    @IBOutlet weak var modelText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var bodyText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="back"{
            
            let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let entity=NSEntityDescription.entity(forEntityName: "Cars", in: context)
            let newCar=NSManagedObject(entity: entity!, insertInto: context) as! Cars
            
            if manufacturerText.text!.isEmpty && modelText.text!.isEmpty && yearText.text!.isEmpty && bodyText.text!.isEmpty {
                
                newCar.manufacturer="AnyManufacturer"
                newCar.model="AnyModel"
                newCar.year="0000"
                newCar.body="Universal"
                
                do {
                    try context.save()
                    
                } catch  {
                    print(error.localizedDescription)
                }
                
            } else {
                
                newCar.manufacturer=manufacturerText.text!
                newCar.model=modelText.text!
                newCar.year=yearText.text!
                newCar.body=bodyText.text!
                
                do {
                    try context.save()
                    
                } catch  {
                    print(error.localizedDescription)
                }
                
            }
        }
    }
}


