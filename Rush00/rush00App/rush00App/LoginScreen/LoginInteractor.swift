//
//  LoginInteractor.swift
//  rush00App
//
//  Created by Yuliya Martsenko on 13.02.2022.
//

import Foundation
import AuthenticationServices

protocol LoginInteractorProtocol {
    func requestToken(completition: @escaping () -> Void)
}

final class LoginInteractor: LoginInteractorProtocol {
    
    //Info about token and authorisation
    
    /// Intra applitcaion UID for OAUTH
    private let UID = "42cbb04ab54d7b92beefa5ff454c2f67d4fb804c73fc7729a8c3bf0332fd24cf"

    /// Intra applitcaion SECRET for OAUTH
    private let SECRET = "66d59ee1b5725472fed180bff27c944dc7c5fdfbc3de31a9c3952013141ab636"

    /// URL path to redirect after OAUTH
    private let redirectString = "https://profile.intra.42.fr/".addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)!

    /// Head for every Intra API request
    private let requestHead = "https://api.intra.42.fr"

    /// Storage with user informaton
    private var userData: UserData?
    
    /// Object that contains information about current session
    private var authorizationData = AuthorizationModel(
        accessToken: "",
        creationDate: 0,
        expiresIn: 0,
        refreshToken: "",
        tokenType: "",
        scope: ""
    )
    
    private weak var delegate: LoginViewController?
    
    func requestToken(completition: @escaping () -> Void) {
        let urlString = "https://api.intra.42.fr/oauth/authorize?client_id=\(UID)&redirect_uri=\(redirectString)&response_type=code";
        let session = ASWebAuthenticationSession(url: URL(string: urlString)!, callbackURLScheme: redirectString) { data, _ in
            if let data = data {
                let url = URL(string: "https://api.intra.42.fr/oauth/token")!

                var request = URLRequest(url: url)
                request.httpBody = "grant_type=authorization_code&client_id=\(self.UID)&client_secret=\(self.SECRET)&\(data.query!)&redirect_uri=\(self.redirectString)".data(using: .utf8)
                request.httpMethod = "POST"

                URLSession.shared.dataTask(with: request) { tokenData, _, _ in
                    if let tokenData = tokenData,
                       let jsonObject = try? JSONDecoder().decode(AuthorizationModel.self, from: tokenData) {
                        self.authorizationData = jsonObject
                        completition()
                        return
                    } else {
                        self.delegate?.showErrorWith(message: "Can't fetch token")
                    }
                }.resume()
            } else {
                self.delegate?.showErrorWith(message: "Can't open OAUTH Authentication Session")
            }
        }
        session.presentationContextProvider = delegate

        DispatchQueue.main.async {
            session.start()
        }
    }
    
    
}
