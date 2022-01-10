//
//  NoteModel.swift
//  TableView
//
//  Created by VirtualMac on 07/01/2022.
//  Copyright © 2022 VirtualMac. All rights reserved.
//

import Foundation

public struct Note {
    private let name:String
    private let deathDate:Date
    private let description:String?
    
    init(name:String, willDie date:String, by description:String?) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        self.name = name
        self.deathDate = formatter.date(from: date)!
        self.description = description
    }
    
    init(name:String, willDie date:String) {
        self.init(name: name, willDie: date, by: nil)
    }
    
    func getDeathDate()->String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        return formatter.string(from: deathDate)
    }
    
    func getDescription()->String {
        if let d = description {
            return d
        } else {
            return ""
        }
    }
    
    func getName()->String {
        return name
    }
}
