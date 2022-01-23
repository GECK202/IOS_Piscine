//
//  Tweet.swift
//  TweetsViewer
//
//  Created by Valeria Karon on 1/23/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import Foundation

struct Tweet: CustomStringConvertible {
    var description: String {
        "name:\(name) text:\(text)"
    }
    
    let name: String
    let text: String
    
}
