//
//  APIDataManager.swift
//  Rush00
//
//  Created by Valeria Karon on 2/13/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import Foundation

class APIDataManager {
    
    //test data
    static var testUser: UserData = UserData(
        id: 1,
        login: "vkaron",
        firstName: "Valeria",
        lastName: "Karon",
        imageURL: URL(string: "https://google.com")!,
        cursusUsers: [UserData.CursusUser(level: 12.25, cursus: UserData.CursusUser.Cursus(id: 1, name: "42")),
            UserData.CursusUser(level: 18.05, cursus: UserData.CursusUser.Cursus(id: 3, name: "42cursus")),
            UserData.CursusUser(level: 7.01, cursus: UserData.CursusUser.Cursus(id: 5, name: "piscine"))],
        campus: [UserData.Campus(id: 27)]
    )
    
    static var testEvents: [EventsModel] {
        get {
            return addTestEvents()
        }
    }
    
    public class func addTestEvents()->[EventsModel] {
        var events = [EventsModel]()
        for index in 0..<10 {
            let event = EventsModel(
                id: index,
                name: "Name of \(index) event",
                description: "description of \(index % 4) event Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.,",
                maxPeople: index * 10,
                numberOfSubscribers: index * 2 + 3,
                location: "location is \(index)\(index)\(index)",
                kind: "Kind number \(index % 3)",
                beginAt: "01.01.0001",
                endAt: "01.01.2200",
                campusIds: [1,2,3,27],
                cursusIds: [1,2,3,4,5]
            )
            events.append(event)
        }
        return events
    }
}
