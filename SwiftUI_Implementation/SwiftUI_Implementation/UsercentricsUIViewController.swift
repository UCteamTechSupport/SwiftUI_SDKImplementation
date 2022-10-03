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
    
    typealias UIViewControllerType = UIViewController
    
    let view = UIViewController()
    
    func makeUIViewController(context: Context) -> UIViewController {

        showFirstLayer()
        
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // TODO
    }
    
    func showFirstLayer() {
        UsercentricsCore.isReady { status in
            let banner = UsercentricsBanner()
            
            banner.showFirstLayer(hostView: view, // UIViewController
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
            
            banner.showSecondLayer(hostView: view) { userResponse in
                print("Consents: \(userResponse)")
            }
        } onFailure: { error in
            print("SDK not yet ready")
        }
    }
    
}
