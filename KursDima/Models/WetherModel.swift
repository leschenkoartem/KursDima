//
//  WetherModel.swift
//  KursDima
//
//  Created by Artem Leschenko on 28.04.2023.
//

import Foundation


struct Wether {
    var name: String
    var temperature: String
    var wether: String
    var wind: String
    //функция подготовки данных для передачи в бд
    var representation:[String: Any]{
        var repres = [String:Any]()
        repres["name"] = self.name
        repres["temperature"] = self.temperature
        repres["wether"] = self.wether
        repres["wind"] = self.wind
        return repres
    }
}
