//
//  SignInView.swift
//  KursDima
//
//  Created by Artem Leschenko on 28.04.2023.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var AcViewM: AcVM
    @State var pass = ""
    @State var email = ""
    @State var alert = false
    @State var textAlert = ""
    @State var signUp = false
    
    var body: some View {
        VStack {
            Text("Sign In")
            
            TextField("Email", text: $email)
            SecureField("Pass", text: $pass)
            Button {
                AuthService.shared.signIn(email: email, password: pass) { result in
                    switch result {
                    case .success(_):
                        print("ok")
                        UserDefaults.standard.set(true, forKey: "UserLoginStatus")
                    case .failure(let error):
                        textAlert = "\(error.localizedDescription)"
                        alert.toggle()
                    }
                }
            } label: {
                Text("Sign IN")
            }.alert(textAlert, isPresented: $alert) {
                Text("OK")
            }
            
            Button {
                signUp.toggle()
            } label: {
                Text("Go to Sign Up")
            }

        }.padding()
            .fullScreenCover(isPresented: $signUp) {
                SignUpView()
            }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().environmentObject(AcVM())
    }
}
