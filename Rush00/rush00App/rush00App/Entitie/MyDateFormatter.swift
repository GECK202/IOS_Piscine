//
//  MyDateFormatter.swift
//  rush00App
//
//  Created by Yuliya Martsenko on 13.02.2022.
//

import Foundation

final class MyDateFormatter {

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter
    }()

    var finalDate: Date?

    init(from string: String) {
        finalDate = dateFormatter.date(from: string)
    }

}
