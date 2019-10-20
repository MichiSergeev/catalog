//
//  EditViewController.swift
//  focusStart
//
//  Created by Mikhail Sergeev on 16.10.2019.
//  Copyright © 2019 Mikhail Sergeev. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var manufacturerText: UITextField!
    @IBOutlet weak var modelText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    @IBOutlet weak var bodyText: UITextField!
    
    var index:Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manufacturerText.text=arrayCars[index!].manufacturer
        modelText.text=arrayCars[index!].model
        yearText.text=arrayCars[index!].yearOfManufacture
        bodyText.text=arrayCars[index!].bodyType
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
