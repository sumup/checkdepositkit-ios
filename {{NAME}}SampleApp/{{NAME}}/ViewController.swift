//
//  ViewController.swift
//  {{NAME}}
//
//  Created by {{AUTHOR}} on {{DAY}}.{{MONTH}}.{{YEAR}}.
//

import {{NAME}}
import SMPIdentity
import UIKit

class ViewController: UIViewController {
    private var autoRefreshObservation: AutoRefreshObservation?

    override func viewDidLoad() {
        super.viewDidLoad()

        AppAuthService.shared.add(observer: self)
        if AppAuthService.shared.loginState.isLoggedIn {
            print("Stored login found, trying to get a valid token...")
            refreshToken(force: false)
        }
        setUpViews()
    }

    private func setUpViews() {
        view.backgroundColor = .white
        navigationItem.title = "ViewController"

        setUpLoginButton()
        setUpSelectServerButton()
    }

    private func setUpSelectServerButton() {
        let selectServerButton = UIBarButtonItem(title: String(describing: IdentityServer.current).capitalized,
                                                 style: .plain,
                                                 target: self,
                                                 action: #selector(selectServer))
        navigationItem.leftBarButtonItem = selectServerButton
    }

    private func setUpLoginButton() {
        let loginButton = IdentityLoginBarButtonItem(presenter: self)
        loginButton.statusChangedBlock = { isLoggedIn, error in
            switch (isLoggedIn, error) {
            case (true, _):
                print("Login success")
            case let (false, .some(error)):
                print("Login failure: \(error.localizedDescription)")
            case (false, .none):
                print("Logout success")
            }
        }
        navigationItem.rightBarButtonItem = loginButton
    }

    @objc private func selectServer() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        IdentityServer.allCases.forEach { server in
            let action = UIAlertAction(title: String(describing: server).capitalized,
                                       style: .default) { action in
                IdentityServer.changeCurrent(server)
                self.navigationItem.leftBarButtonItem?.title = action.title
            }
            actionSheet.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true)
    }

    private func refreshToken(force: Bool) {
        AppAuthService.shared.getToken(forceRefresh: force) { [weak self] result in
            self?.handleTokenRefreshResult(result: result)
        }
    }

    private func handleTokenRefreshResult(result: AppAuthService.GetTokenResult) {
        switch result {
        case let .success(accessToken):
            print("Acquired a valid token.")
            print("[ACCESS_TOKEN] \(accessToken)")
        case let .failure(error):
            print("Failed to get a valid token.")
            print("[ERROR] \(error)")
        }
    }
}

extension ViewController: AutoRefreshObserver {
    func didRefresh(accessToken: String) {
        print("Token refreshed: \(accessToken)")
    }

    func didInvalidateLogin() {
        print("Login invalidated")
    }

    func didStopAutoRefreshDueToFailure(_ error: Error) {
        print("Auto-refresh stopped due to failure: \(error.localizedDescription)")
    }
}
