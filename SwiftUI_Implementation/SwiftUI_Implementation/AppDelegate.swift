//
//  AppDelegate.swift
//  SwiftUI_Implementation
//
//  Created by Rui Reis on 25/11/2022.
//

import Foundation
import Usercentrics
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application:UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool
    {
        let options = UsercentricsOptions(settingsId: SDKInitData().settingsId)
        UsercentricsCore.configure(options: options)
        print("Usercentrics initialized")
        UsercentricsCore.isReady { it in
            print(it.consents)
        } onFailure: { error in
            print("[Usercentrics][Error]: \(error)")
        }
        
        return true
    }
}
