//
//  Cat.swift
//  TheCatApp
//
//  Created by isha pathak on 30/06/22.
//

import UIKit

// MARK: Model to structure the Cat object
class Cat: Codable {
    let breeds : [String]
    let categories : [Category]
    let id : String
    let url : URL
    
    init(breeds: [String], categories: [Category], id: String, url: URL) {
        self.breeds = breeds
        self.categories = categories
        self.id = id
        self.url = url
    }
}

class Category: Codable {
    let id : Int
    let name : String
}

