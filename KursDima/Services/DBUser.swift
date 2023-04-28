import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI
import FirebaseStorage


class DBUserService{
    
    static var shared = DBUserService()
    //1) делаем переменную обращения датабазы 2) Делаем ссылку на список "users"
    let dB = Firestore.firestore()
    
    var userRef:CollectionReference{
        return dB.collection("users")
    }
        
    
    //Делаем инит приватным для запрета создания еще одного
    private init(){ }
    
    //Запись юзера в базу даных
    func setProfile(user: MUser, completion:@escaping (Result<MUser, Error>)->()){
        userRef.document(user.id).setData(user.representation) { error in
            if let error = error{
                completion(.failure(error))
            }else{
                completion(.success(user))
            }
        }
    }
    
    //Функция, которая заберает инфу про пользователя с бд
    func getProfile() async throws -> MUser {
        guard let currentUser = AuthService.shared.currentUser else { throw AppError.currentUserNil }
        
        let docSnapshot = try await userRef.document(currentUser.uid).getDocument()
        guard let data = docSnapshot.data() else { throw AppError.dataNotFound }
        guard let userID = data["id"] as? String else { throw AppError.userIDNotFound }
        guard let userEmail = data["email"] as? String else { throw AppError.userEmailNotFound }
        guard let isAdmin = data["isAdmin"] as? Bool else { throw AppError.userEmailNotFound }
        
        let userObject = MUser(id: userID, email: userEmail, isAdmin: isAdmin)
        return userObject
    }
}

enum AppError: Error {
    case currentUserNil
    case dataNotFound
    case userNameNotFound
    case userIDNotFound
    case userEmailNotFound
    case userBalanceNotFound
    case userImageNotFound
    case downloadURLNotFound
}

