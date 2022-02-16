//
//  LoginViewController.swift
//  rush00App
//
//  Created by Yuliya Martsenko on 13.02.2022.
//

import UIKit
import AuthenticationServices

protocol LoginViewControllerInput: class {
    func showErrorWith(message: String)
}

class LoginViewController: UIViewController {
    
    private var authentificationService: AuthenticationServiceProtocol?
    
    /// Interactor instance for ViewController
    private let interactor = LoginInteractor()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8.0
        button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.backgroundColor = .darkGray
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(action), for: .touchUpInside)
        return button
    }()
    
    @objc func action() {
        interactor.requestToken {
            
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(loginButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }

}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
}

extension LoginViewController: LoginViewControllerInput {
    func showErrorWith(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
