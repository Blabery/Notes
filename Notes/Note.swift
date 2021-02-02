//
//  Note.swift
//  lab_1
//
//  Created by Владислав Якубец on 26.11.2020.
//

import UIKit

class Note: NSObject, NSCoding {
    
    var title: String
    var text: String
    var date: String
    var important: Int
    
    required init?(coder: NSCoder) {
        title = coder.decodeObject(forKey: "title") as? String ?? ""
        text = coder.decodeObject(forKey: "text") as? String ?? ""
        date = coder.decodeObject(forKey: "date") as? String ?? ""
        important = coder.decodeInteger(forKey: "important") as Int 
    }
    
    init(title: String, text: String, date: String, important: Int) {
        self.title = title
        self.text = text
        self.date = date
        self.important = important
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(text, forKey: "text")
        coder.encode(date, forKey: "date")
        coder.encode(important, forKey: "important")
    }
    
}
