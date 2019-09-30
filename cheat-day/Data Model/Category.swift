//
//  Category.swift
//  todoey
//
//  Created by Francesca Koulikov on 9/11/19.
//  Copyright © 2019 Francesca Koulikov. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    @objc dynamic var image: String = ""
    let items = List<Item>()
}
