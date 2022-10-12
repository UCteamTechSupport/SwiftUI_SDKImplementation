//
//  ContentView.swift
//  SwiftUI_Implementation
//
//  Created by Rui Reis on 03/10/2022.
//

import SwiftUI
import Usercentrics

struct ContentView: View {
    
    init() {
        let options = UsercentricsOptions(settingsId: "hKTmJ4UVL")
        UsercentricsCore.configure(options: options)
        print("Usercentrics initialized")
        UsercentricsCore.isReady { it in
            print(it.consents)
        } onFailure: { error in
            print("[Usercentrics][Error]: \(error)")
        }
    }
    
    var body: some View {
        VStack {
            Image("usercentrics")
                .imageScale(.large)
                .padding(30)
                .frame(width: 200, height: 100)
            
            Spacer()
            VStack{
                Button("Show First Layer"){
                    UsercentricsUIViewController().showFirstLayer()
                    
                }
                .frame(width: 200, height: 50)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(5)
                .padding(5)
                
                Button("Show Second Layer"){
                    UsercentricsUIViewController().showSecondLayer()
                }
                .frame(width: 200, height: 50)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(5)
                .padding(5)
                
                Button("Show WebView"){
                    UsercentricsUIViewController().restoreUserSession(url: "https://app.usercentrics.eu/browser-ui/preview/index.html?settingsId=\(SDKInitData().settingsId)")
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
