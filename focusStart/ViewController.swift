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
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier=="back"{
            
            let newCar=CarsRealm()
            
            if manufacturerText.text!.isEmpty && modelText.text!.isEmpty && yearText.text!.isEmpty && bodyText.text!.isEmpty {
                
                newCar.manufacturer="AnyManufacturer"
                newCar.model="AnyModel"
                newCar.year="0000"
                newCar.body="Universal"
                
                try! realm.write {
                    realm.add(newCar)
                }
                
            } else {
                newCar.manufacturer=manufacturerText.text!
                newCar.model=modelText.text!
                newCar.year=yearText.text!
                newCar.body=bodyText.text!
                
                
                try! realm.write {
                    realm.add(newCar)
                }
                
            }
        }
    }
}


