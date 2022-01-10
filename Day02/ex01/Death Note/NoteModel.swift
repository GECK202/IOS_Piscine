//
//  NoteModel.swift
//  Death Note
//
//  Created by VirtualMac on 07/01/2022.
//  Copyright © 2022 VirtualMac. All rights reserved.
//

import Foundation

public struct Note {
    private let name: String
    private let deathDate: Date
    private let description: String?
    
    init(name: String, date: String, description: String?) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        self.name = name
        self.deathDate = formatter.date(from: date)!
        self.description = description
    }
    
    init(name: String, date: String) {
        self.init(name: name, date: date, description: nil)
    }
    
    func getName()->String {
        return name
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
}
