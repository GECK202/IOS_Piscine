//
//  UserData.swift
//  rush00App
//
//  Created by Yuliya Martsenko on 13.02.2022.
//

import Foundation

struct UserData: Decodable {
    
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
    struct Campus: Decodable {
        let id: Int
    }
    
    struct CursusUser: Decodable {
        let level: Double

        struct Cursus: Decodable {
            let id: Int
            let name: String
        }
        let cursus: Cursus
    }
}
