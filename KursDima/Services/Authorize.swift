import Foundation
import FirebaseAuth

class AuthService{
    
    static let shared = AuthService()
    private let auth = Auth.auth()
    var currentUser: User? {
        UserDefaults.standard.set( auth.currentUser != nil, forKey: "UserLoginStatus" )
        return auth.currentUser
    }
       
    //Функция для регистрации
    func signUp(email:String, password:String, isAdmin: Bool, completion:@escaping(Result<User, Error>)->() ){
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result = result{
                //Создаэм юзера
                let user = MUser(id: result.user.uid, email: email, isAdmin: isAdmin)
                //помещаем его в базу данных
                DBUserService.shared.setProfile(user: user) { resultDB in
                    switch resultDB {
                    case .success(_):
                        completion(.success(result.user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                completion(.success(result.user))
            }else if let error = error{
                completion(.failure(error))
            }
        }
    }
    
    //функция для входа
    func signIn(email:String, password:String, completion:@escaping(Result<User, Error>)->() ){
        auth.signIn(withEmail: email, password: password) { result, error in
            if let result = result{
                completion(.success(result.user))
            }else if let error = error{
                completion(.failure(error))
            }
        }
    }
    
    //Функция выхода из пользователя
    func signOut(){
        try? Auth.auth().signOut()
    }
    
}
