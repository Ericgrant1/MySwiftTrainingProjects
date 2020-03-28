//
//  AuthenticationService.swift
//  MyVKNewsFeed
//
//  Created by Eric Grant on 12.03.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import Foundation
import VKSdkFramework

// 8.
protocol AuthServiceDelegate: class {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
}
// 8.

// 4.
final class AuthenticationService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "7354567"
    private let vkSDK: VKSdk
    
    override init() {
        vkSDK = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk.initialize")
        
        vkSDK.register(self)
        vkSDK.uiDelegate = self
    }
    
    // 9. Для использования функций Протокола
    weak var delegate: AuthServiceDelegate?
    // 9.
    
    // 19.
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    // 19.
    
    // 221.
    var userId: String? {
        return VKSdk.accessToken()?.userId
    }
    // 221.
    
    // 6. Проверка авторизации
    func wakeUpSession() {
        let scope = ["wall", "friends"]
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            switch state {
            case .initialized:
                print("initialized")
                VKSdk.authorize(scope)
            case .authorized:
                print("authorized")
                // 15.
                delegate?.authServiceSignIn()
            default:
                delegate?.authServiceSignInDidFail()
                // fatalError(error!.localizedDescription)
                // 15.
            }
        }
    }
    // 6.
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        // 12. Проверка получения токена
        if result.token != nil {
            delegate?.authServiceSignIn() // 9.1            
        }
        // 12.
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSignInDidFail() // 9.2
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewController: controller) // 9.3
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
}
// 4.
