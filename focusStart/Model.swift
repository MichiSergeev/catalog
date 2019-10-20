//
//  Model.swift
//  ar_book
//
//  Created by Mikhail Sergeev on 15.10.2019.
//  Copyright © 2019 Михаил Сергеев. All rights reserved.
//

import Foundation
import RealmSwift


// модель базы данных
class CarsRealm:Object {
    @objc dynamic var manufacturer:String=""
    @objc dynamic var model:String=""
    @objc dynamic var year:String=""
    @objc dynamic var body:String=""
}


// доступ к хранилищу
let realm = try! Realm()

