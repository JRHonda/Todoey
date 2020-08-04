//
//  Item.swift
//  Todoey
//
//  Created by Justin Honda on 8/2/20.
//  Copyright © 2020 Laguna Labs. All rights reserved.
//

import Foundation

class Item : Codable {
    var title: String = String.Empty
    var isDone: Bool = false
    
    init(title: String, isDone: Bool = false) {
        self.title = title
        if (isDone) {
            self.isDone = isDone
        }
    }
}
