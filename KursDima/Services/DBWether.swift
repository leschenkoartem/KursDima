import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI
import FirebaseStorage


class DBWether{
    
    
    static var shared = DBWether()
    //1) делаем переменную обращения датабазы 2) Делаем ссылку на список "users"
    let dB = Firestore.firestore()
    
    var cityRef: CollectionReference{
        return dB.collection("cityes")
    }

    //Делаем инит приватным для запрета создания еще одного
    private init(){ }
    
    
    //Добавление лота
    func addLotToFirestore(city: Wether) {
        
        var docData: [String: Any] = city.representation
        
        cityRef.document(city.name).setData(docData) { error in
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
            } else {
                print("Document added with ID: \(self.cityRef)")
            }
        }
    }
    
    
    //Получение лота
    func getLots(completion: @escaping (Result<[Wether], Error>) -> Void) {
        
        //Фільтри на стороні клієнта
        var query: Query = cityRef
    
        query.getDocuments { qSnap, error in
            guard let qSnap = qSnap else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            print(Date().description)
            let cityes = qSnap.documents.compactMap { doc -> Wether? in
                guard let name = doc["name"] as? String,
                      let temperature = doc["temperature"] as? String,
                      let wether = doc["wether"] as? String,
                      let wind = doc["wind"] as? String else {
                    return nil
                }
                return Wether(name: name, temperature: temperature, wether: wether, wind: wind)
            }
            
            completion(.success(cityes))
        }
    }
}

