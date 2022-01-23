//
//  APITwitterDelegate.swift
//  TweetsViewer
//
//  Created by Valeria Karon on 1/23/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import Foundation

protocol APITwitterDelegate: AnyObject {

    func manage(tweets: [Tweet])
    func error(error: NSError)

}
