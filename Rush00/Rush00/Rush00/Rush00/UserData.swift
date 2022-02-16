//
//  UserData.swift
//  Rush00
//
//  Created by Valeria Karon on 2/13/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import Foundation

public struct UserData: Decodable {
    
    // Variables
    let id: Int
    let login: String
    let firstName: String
    let lastName: String
    let imageURL: URL
    var events: [EventsModel]?
    let cursusUsers: [CursusUser]
    let campus: [Campus]
    
    // Coding keys
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case firstName = "first_name"
        case lastName = "last_name"
        case imageURL = "image_url"
        case events
        case cursusUsers = "cursus_users"
        case campus
    }
    
    // Structs
    public struct Campus: Decodable {
        let id: Int
    }
    
    public struct CursusUser: Decodable {
        let level: Double

        public struct Cursus: Decodable {
            let id: Int
            let name: String
        }
        let cursus: Cursus
    }
}
