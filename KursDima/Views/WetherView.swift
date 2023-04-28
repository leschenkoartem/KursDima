//
//  WetherView.swift
//  KursDima
//
//  Created by Artem Leschenko on 28.04.2023.
//

import SwiftUI

struct WetherView: View {
    
    @State var wehers = [Wether]()
    
    var body: some View {
        VStack {
            LazyVStack {
                ForEach(wehers, id: \.name) { weher in
                    Text(weher.name)
                }
            }
            
        }.onAppear {
            DBWether.shared.getLots { result in
                switch result {
                case .success(let wet):
                    wehers = wet
                case .failure(_):
                    print("error")
                }
            
            }
        }
    }
}

struct WetherView_Previews: PreviewProvider {
    static var previews: some View {
        WetherView()
    }
}
