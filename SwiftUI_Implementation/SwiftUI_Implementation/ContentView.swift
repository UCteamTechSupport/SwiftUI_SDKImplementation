//
//  ContentView.swift
//  SwiftUI_Implementation
//
//  Created by Rui Reis on 03/10/2022.
//

import SwiftUI
import Usercentrics
import UsercentricsUI

struct ContentView: View {
    let banner = UsercentricsBanner()
    
//    init() {
//        let options = UsercentricsOptions(settingsId: SDKInitData().settingsId)
//        UsercentricsCore.configure(options: options)
//        print("Usercentrics initialized")
//        UsercentricsCore.isReady { it in
//            print(it.consents)
//        } onFailure: { error in
//            print("[Usercentrics][Error]: \(error)")
//        }
//    }
    
    var body: some View {
        VStack {
            Image("usercentrics")
                .imageScale(.large)
                .padding(30)
                .frame(width: 200, height: 100)
            
            Spacer()
            VStack{
                Button("Show First Layer"){
//                    banner.showFirstLayer(){ userResponse in
//                        print(userResponse.consents)
//                    }
                    UsercentricsUIViewController().showFirstLayer()
                }
                .frame(width: 200, height: 50)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(5)
                .padding(5)
                
                Button("Show Second Layer"){
//                    banner.showSecondLayer(){ userResponse in
//                        print(userResponse.consents)
//                    }
                    UsercentricsUIViewController().showSecondLayer()
                    
                }
                .frame(width: 200, height: 50)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(5)
                .padding(5)
                
                Button("Show WebView"){
                    UsercentricsUIViewController().restoreUserSession(url: "https://app.usercentrics.eu/browser-ui/preview/index.html?settingsId=\(SDKInitData().settingsId)")
//                    UsercentricsUIViewController().restoreUserSession(url: "https://app.usercentrics.eu/browser-ui/preview/index.html?settingsId=\(SDKInitData().settingsId)")
                }
                .frame(width: 200, height: 50)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(5)
                .padding(5)
            }
            .padding(100)
        }
        .padding(50)
        Spacer()
        UsercentricsUIViewController()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
