//
//  MyDateFormatter.swift
//  Rush00
//
//  Created by Valeria Karon on 2/13/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
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
