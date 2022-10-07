//
//  UsercentricsUIViewController.swift
//  CMPTest
//
//  Created by Rui Reis on 03/10/2022.
//

import Foundation
import SwiftUI
import Usercentrics
import UsercentricsUI

struct UsercentricsUIViewController: UIViewControllerRepresentable {
    
    private let tableView: UITableView = UITableView(frame: .zero, style: .grouped)

    
    typealias UIViewControllerType = UIViewController
    
    let view = UIViewController()
    
    func makeUIViewController(context: Context) -> UIViewController {
                        
        return view
    }
    
    func getTopMostViewController() -> UIViewController? {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first else { return nil }
        var topMostViewController = window.rootViewController
        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }

        return topMostViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // TODO
    }
    
    func showFirstLayer() {
        
        UsercentricsCore.isReady { status in
            let banner = UsercentricsBanner()
            
            let newView = getTopMostViewController() ?? view
                
            banner.showFirstLayer(hostView: newView, // UIViewController
                                  layout: UsercentricsLayout.sheet) { userResponse in
                print("Consents: \(userResponse)")
            }
        } onFailure: { error in
            print("SDK not yet ready")
        }
    }
    
    func showSecondLayer() {
        
        UsercentricsCore.isReady { status in
            let banner = UsercentricsBanner()
            
            let newView = getTopMostViewController() ?? view

            banner.showSecondLayer(hostView: newView) { userResponse in
                print("Consents: \(userResponse)")
            }
        } onFailure: { error in
            print("SDK not yet ready")
        }
    }
    
}
