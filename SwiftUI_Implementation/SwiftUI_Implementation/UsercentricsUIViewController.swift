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
import WebKit

struct UsercentricsUIViewController: UIViewControllerRepresentable {
    let LOG_TAG = "[USERCENTRICS][ERROR]: "
    
    typealias UIViewControllerType = UIViewController
    
    let view = UIViewController()
    
    // Two stubs for implementation of UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> UIViewController {
                        
        return view
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // TODO
    }
    
    // Getting top most view for showLayer API calls
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
    
    func showFirstLayer() {
        
        UsercentricsCore.isReady { status in
            let banner = UsercentricsBanner(bannerSettings: getBannerSettings())
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
            
            let banner = UsercentricsBanner(bannerSettings: getBannerSettings())
            
            let newView = getTopMostViewController() ?? view

            banner.showSecondLayer(hostView: newView) { userResponse in
                print("Consents: \(userResponse)")
            }
        } onFailure: { error in
            print("SDK not yet ready")
        }
    }
    
    func restoreUserSession(url: String) {
        let view = getTopMostViewController()
        
        var myWebView: WKWebView
        let sessionData = UsercentricsCore.shared.getUserSessionData()
        
        let script = """
            window.UC_UI_USER_SESSION_DATA = \(sessionData);
        """
        
        let log = """
            console.log(window.UC_UI_USER_SESSION_DATA);
        """
        
        let userScript = WKUserScript(source: script, injectionTime: .atDocumentStart, forMainFrameOnly: true)
        let logScript = WKUserScript(source: log, injectionTime: .atDocumentStart, forMainFrameOnly: true)
        let contentController = WKUserContentController()
        contentController.addUserScript(userScript)
        contentController.addUserScript(logScript)
        
        print("Open Webview Button Tapped")
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.defaultWebpagePreferences.allowsContentJavaScript = true
        webConfiguration.userContentController = contentController
        myWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        //webView.configuration.preferences.javaScriptEnabled = true
        //myWebView.uiDelegate = self
        
        myWebView.frame = view!.view.bounds
        myWebView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view!.view.addSubview(myWebView)
        
        let myUrl = URL(string: url)
        if myUrl == nil {
            print("\(LOG_TAG) URL provided is not properly formatted.")
            
        }
        
        let myRequest = URLRequest(url: myUrl!)
        myWebView.load(myRequest)
    }
    
    func getBannerSettings() -> BannerSettings {
        // Layer Style definitions
        let toggleStyleSettings = ToggleStyleSettings(activeBackgroundColor: UIColor.green,
                                                     inactiveBackgroundColor: UIColor.cyan,
                                                     disabledBackgroundColor: UIColor.magenta,
                                                     activeThumbColor: UIColor.blue,
                                                     inactiveThumbColor: UIColor.brown,
                                                     disabledThumbColor: UIColor.systemPink)

        let generalStyleSettings = GeneralStyleSettings(font: BannerFont(
                                                            regularFont:  UIFont(name: "Avenir", size: 15)!,
                                                            boldFont: UIFont(name: "Avenir-Heavy", size: 15)!
                                                        ),
                                                        logo: UIImage(named: "hat-head-king-svgrepo-com"),
                                                        links: .firstLayerOnly,
                                                        textColor: UIColor.magenta,
                                                        layerBackgroundColor: UIColor.black,
                                                        layerBackgroundSecondaryColor: UIColor.black,
                                                        linkColor: UIColor.green,
                                                        tabColor: UIColor.red,
                                                        bordersColor: UIColor.darkGray,
                                                        toggleStyleSettings: toggleStyleSettings)


        let firstLayerSettings = FirstLayerStyleSettings(headerImage: nil,
                                         title: getTitleSettings(),
                                         message: getMessageSettings(),
                                         buttonLayout: getButtonLayout(),
                                         backgroundColor:UIColor(red: 218, green: 218, blue: 218, alpha: 1.0),
                                         cornerRadius: 20
                                    )

        let secondLayerSettings = SecondLayerStyleSettings(
                                            buttonLayout: ButtonLayout.column(),
                                            showCloseButton: true
                                )
        
        return BannerSettings(
            generalStyleSettings: generalStyleSettings,
            firstLayerStyleSettings: firstLayerSettings,
            secondLayerStyleSettings: secondLayerSettings
        )
    }
    
    func getTitleSettings() -> TitleSettings {
        return TitleSettings(font: UIFont(name: "Avenir", size: 25), textColor: .black, textAlignment: .left)
    }
    
    
    func getMessageSettings() -> MessageSettings {
        return MessageSettings(font: UIFont(name: "Avenir", size: 15), textColor: .black, textAlignment: .left, linkTextColor: .blue)
    }
    
    func getButtonLayout() -> ButtonLayout {
        let acceptButton = ButtonSettings(type: .acceptAll, font: UIFont(name: "Avenir", size: 12), cornerRadius: 18)
        let denyButton = ButtonSettings(type: .denyAll, font: UIFont(name: "Avenir", size: 12), cornerRadius: 18)
        let moreButton = ButtonSettings(type: .more, font: UIFont(name: "Avenir", size: 12), textColor: .black, backgroundColor: .orange, cornerRadius: 18)
        
        return ButtonLayout.row(buttons: [acceptButton, denyButton, moreButton])
    }
}
