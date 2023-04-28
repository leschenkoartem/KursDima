//
//  HomeView.swift
//  KursDima
//
//  Created by Artem Leschenko on 28.04.2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var AcVewM: AcVM
    @State var city = ""
    @State var wether = ""
    @State var wind = ""
    @State var temperature = ""
    
    
    var body: some View {
        VStack {
            Button {
                AuthService.shared.signOut()
                UserDefaults.standard.set(false, forKey: "UserLoginStatus")
            } label: {
                Text("SignOut")
            }.padding(.vertical, 70)
            Text("\(AcVewM.profile.email)")
            if AcVewM.profile.isAdmin {
                Text("Admin")
                TextField("City", text: $city)
                TextField("wether", text: $wether)
                TextField("wind", text: $wind)
                TextField("temperature", text: $temperature)
                
                Button {
                    DBWether.shared.addLotToFirestore(city: Wether(name: city, temperature: temperature, wether: wether, wind: wind))
                } label: {
                    Text("Add")
                }

            }
            
            Spacer()
        }.onAppear {
            Task {
                AcVewM.getProfile()
            }
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(AcVM())
    }
}
