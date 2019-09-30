//
//  Item.swift
//  
//
//  Created by Francesca Koulikov on 9/11/19.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated: Date?
    @objc dynamic var calories: Float = 0.0
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
