import UIKit
import CoreData

class EditViewController: UIViewController {
    
    @IBOutlet weak var manufacturerText: UITextField!
    @IBOutlet weak var modelText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var bodyText: UITextField!
    
    
    var editingCar=Cars()
    var context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manufacturerText.text=editingCar.manufacturer
        modelText.text=editingCar.model
        yearText.text=editingCar.year
        bodyText.text=editingCar.body

    }
    
    

     // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="back" {
            
            editingCar.manufacturer=manufacturerText.text!
            editingCar.model=modelText.text!
            editingCar.year=yearText.text!
            editingCar.body=bodyText.text!

            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
