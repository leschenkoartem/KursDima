//
//  ContentView.swift
//  KursDima
//
//  Created by Artem Leschenko on 28.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    @AppStorage("UserLoginStatus")
    var userLogIn = UserDefaults.standard.bool(forKey: "UserLoginStatus")
    
    var body: some View {
                if userLogIn {
        TabView(selection: $selection) {
            WetherView().tabItem {
                Image(systemName: "xmark")
            }.tag(0)
            HomeView().tabItem {
                Image(systemName: "xmark")
            }.tag(1)
        }
                } else {
                    SignInView()
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
