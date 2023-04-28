//
//  UserModel.swift
//  KursDima
//
//  Created by Artem Leschenko on 28.04.2023.
//

import Foundation
import FirebaseAuth

struct MUser:Identifiable{
    //Структура пользователя
    var id:String
    var email:String
    var isAdmin: Bool
    //функция подготовки данных для передачи в бд
    var representation:[String: Any]{
        var repres = [String:Any]()
        repres["id"] = self.id
        repres["email"] = self.email
        repres["isAdmin"] = self.isAdmin
        return repres
    }
}
