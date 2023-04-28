//
//  AcVM.swift
//  KursDima
//
//  Created by Artem Leschenko on 28.04.2023.
//

import Foundation
import SwiftUI


class AcVM: ObservableObject{
    
    @Published var profile = MUser(id: "", email: "", isAdmin: false)
     
    init() {
        getProfile()
    }

    //Функция, для получение пользователя на экран
    func getProfile() {
        Task { [weak self] in
            self?.profile = try await DBUserService.shared.getProfile()
        }
    }
}
