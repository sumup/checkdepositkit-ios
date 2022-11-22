//
//  AuthTokenProvider+{{NAME}}.swift
//  {{NAME}}
//
//  Created by {{AUTHOR}} on {{DAY}}.{{MONTH}}.{{YEAR}}.
//

import SMPIdentity

class LegacyTokenProvider: AuthTokenProvider {
    static let shared: LegacyTokenProvider = .init()

    var token: String?

    func getToken(resultBlock: @escaping GetTokenResultBlock) {
        guard let token = token else {
            resultBlock(.failure(.notLoggedIn))
            return
        }
        resultBlock(.success(token))
    }
}

class InfoProviderDefault: AppAuthInfoProvider {
    static let shared = InfoProviderDefault()

    var email: String?
    var preferredLanguages: [String]?
    var deviceId: String?
    var keyId: String?
}
