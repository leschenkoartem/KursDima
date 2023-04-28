//
//  SignUpView.swift
//  KursDima
//
//  Created by Artem Leschenko on 28.04.2023.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @State var pass = ""
    @State var email = ""
    @State var isAdmin = false
    @State var alert = false
    @State var textAlert = ""
    @State var signUp = false
    
    var body: some View {
        VStack {
            Text("Sign Up")
            
            TextField("Email", text: $email)
            SecureField("Pass", text: $pass)
            HStack {
                Text("IsAdmin:")
                Toggle("", isOn: $isAdmin)
            }
            
            Button {
                AuthService.shared.signUp(email: email, password: pass, isAdmin: isAdmin) { result in
                    switch result {
                    case .success(_):
                        print("ok")
                    case .failure(let error):
                        textAlert = "\(error.localizedDescription)"
                        alert.toggle()
                    }
                }
            } label: {
                Text("Sign Up")
            }.alert(textAlert, isPresented: $alert) {
                Text("OK")
            }
            
            Button {
                dismiss()
            } label: {
                Text("Return")
            }

        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
