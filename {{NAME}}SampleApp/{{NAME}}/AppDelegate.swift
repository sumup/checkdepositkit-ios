//
//  AppDelegate.swift
//  {{NAME}}
//
//  Created by {{AUTHOR}} on {{DAY}}.{{MONTH}}.{{YEAR}}.
//

import SMPIdentity
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = ViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        AppAuthService.setup(infoProvider: InfoProviderDefault.shared)
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        if AppAuthService.shared.handleResponse(url: url) {
            return true
        }
        return false
    }
}
