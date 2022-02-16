//
//  AuthenticationModel.swift
//  rush00App
//
//  Created by Yuliya Martsenko on 13.02.2022.
//

import Foundation

// Struct that decode /oauth/authorize endpoint
struct AuthorizationModel: Decodable {
    let accessToken: String
    let creationDate: Int
    let expiresIn: Int
    let refreshToken: String
    let tokenType: String
    let scope: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case creationDate = "created_at"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case scope
    }
}
