//
//  EventsModel.swift
//  Rush00
//
//  Created by Valeria Karon on 2/13/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//
import Foundation

public struct EventsModel: Decodable {
    let id: Int
    let name: String
    let description: String
    let maxPeople: Int?
    let numberOfSubscribers: Int
    let location: String
    let kind: String
    let beginAt: String
    let endAt: String
    let campusIds: [Int]
    let cursusIds: [Int]

    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case maxPeople = "max_people"
        case numberOfSubscribers = "nbr_subscribers"
        case location
        case kind
        case beginAt = "begin_at"
        case endAt = "end_at"
        case campusIds = "campus_ids"
        case cursusIds = "cursus_ids"
    }
    
    static func ==(lhs: EventsModel, rhs: EventsModel) -> Bool {
        lhs.name == rhs.name
    }
}

enum EventKind {
    case regular
    case subscrible
    case unsubscrible
}

struct EventsEntity {
    let id: Int
    let name: String
    let description: String
    let maximumGuests: Int?
    let currentRegisteredGuests: Int
    let location: String
    let type: String
    let duration: Int?
    let startingTime: Date
    let endTime: Date
    let campusId: [Int]
    let cursusId: [Int]
    let eventKind: EventKind

    init(from model: EventsModel, with userData: UserData) {
        id = model.id
        name = model.name
        description = model.description
        self.maximumGuests = model.maxPeople
        currentRegisteredGuests = model.numberOfSubscribers
        location = model.location
        type = model.kind
        self.startingTime = MyDateFormatter(from: model.beginAt).finalDate!
        self.endTime = MyDateFormatter(from: model.endAt).finalDate!
        self.duration = Calendar.current.dateComponents([.day, .hour, .minute], from: startingTime, to: endTime).hour
        campusId = model.campusIds
        cursusId = model.cursusIds

        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()

            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            return dateFormatter
        }()

        if userData.events?.first(where: { $0 == model }) != nil {
            eventKind = .unsubscrible
        } else {
            if let endDate = dateFormatter.date(from: model.endAt),
               endDate > Date(),
               campusId.first(where: { campusId in userData.campus.first(where: { $0.id == campusId }) != nil }) != nil,
               cursusId.first(where: { cursusId in userData.cursusUsers.first(where: { $0.cursus.id == cursusId }) != nil }) != nil {
                eventKind = .subscrible
            } else {
                eventKind = .regular
            }
        }
    }
}

