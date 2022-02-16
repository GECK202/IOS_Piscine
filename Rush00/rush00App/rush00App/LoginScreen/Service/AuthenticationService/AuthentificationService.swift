//
//  AuthentificationService.swift
//  rush00App
//
//  Created by Yuliya Martsenko on 13.02.2022.
//

import Foundation
import AuthenticationServices

protocol AuthenticationServiceProtocol {
    func logIn()
}

final class AuthenticationService: AuthenticationServiceProtocol {
    
    func logIn() {
        // Use the URL and callback scheme specified by the authorization provider.
        guard let authURL = URL(string: "https://example.com/auth") else { return }
        let scheme = "exampleauth"

        // Initialize the session.
        let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: scheme)
        { callbackURL, error in
            // Handle the callback.
        }
    }

}
