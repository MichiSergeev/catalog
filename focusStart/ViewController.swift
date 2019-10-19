//
//  ViewController.swift
//  focusStart
//
//  Created by Mikhail Sergeev on 15.10.2019.
//  Copyright © 2019 Mikhail Sergeev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var manufacturerText: UITextField!
    
    @IBOutlet weak var modelText: UITextField!
    
    @IBOutlet weak var yearText: UITextField!
    
    @IBOutlet weak var bodyText: UITextField!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier=="save" {
            
            var newCar:Car
            
            if manufacturerText.text!.isEmpty && modelText.text!.isEmpty && yearText.text!.isEmpty && bodyText.text!.isEmpty {
                newCar=Car(manufacturer: "FirmaTest", model: "ModelTest", yearOfManufacture: "2000", bodyType: "CoupeTest")
                arrayCars.append(newCar)
            } else {
                newCar=Car(manufacturer: manufacturerText.text!, model: modelText.text!, yearOfManufacture: yearText.text!, bodyType: bodyText.text!)
                arrayCars.append(newCar)
            }
        }
    }
}
