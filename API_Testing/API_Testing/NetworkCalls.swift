import Foundation
import BioHaazNetwork
class NetworkCalls: NSObject {

    static let shared = NetworkCalls()
    let newInterceptor = ApiInterceptor()
    let newTracker = ApiTracker()
    
    let usersDetails = "user/details"
    let userById = "user/"
    let newUser = "user/create"
    let updateUserURL = "update/"
    let deleteUserURL = "delete/"
    
    func initilizedFramework() -> Bool {
        let config = BioHaazNetworkConfig(
            environments: [
                .prod: "http://3.225.127.58:8080/api/"
            ],
            defaultEnvironment: .prod, debug: true)
        BioHaazNetworkManager.shared.initialize(with: config)
        print("BioHaazNetworkManager initialized ")
        return true
    }
//    
//    func getAllUsers(){
//        BioHaazNetworkManager.shared.request(
//            method: "GET",
//            url: self.usersDetails,
//            headers: [:],
//            params: nil
//        ) { result in
//            switch result {
//            case .success(let data):
//                do{
//                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                    print(jsonData)
//                }catch{
//                    print(error.localizedDescription)
//                }
//                break
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    func getAllUsers(completion: @escaping ([UsersData]?, Error?) -> Void){
        print("getAllUsers")
        BioHaazNetworkManager.shared.request(
            method: "GET",
            url: self.usersDetails,
            headers: [:],
            params: nil
        ) { result in
            print("getAllUsers inside request")
            switch result {
            case .success(let data):
                do {
                    let users = try JSONDecoder().decode([UsersData].self, from: data)
                    completion(users, nil)
                } catch {
                    print("Decoding failed:", error.localizedDescription)
                    print(error)
                    completion(nil, error)
                }
                break
            case .failure(let error):
                print("this is from network failure")
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func getSingleUsers(userId: Int, completion: @escaping (UsersData?, Error?) -> Void) {
        BioHaazNetworkManager.shared.request(
            method: "GET",
            url: "\(self.userById)\(userId)",
            headers: [:],
            params: nil
        ) { result in
            switch result {
            case .success(let data):
               // let users = try JSONDecoder().decode([UsersData], from: data)
                do {
//                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    let jsonData = try JSONDecoder().decode(UsersData.self, from: data)
                    
                    completion(jsonData, nil)
                } catch  {
                    print(error.localizedDescription)
                    completion(nil, error)
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func createUser(fname:String, lname: String, gen: String, pnumber:String, email: String, address: String){
        let params = ["firstName":fname,
                      "secondName": lname,
                      "gender": gen,
                      "phoneNumber": pnumber,
                      "email": email,
                      "address": address] as NSDictionary
        print(params)
        BioHaazNetworkManager.shared.request(
            method: "POST",
            url: self.newUser ,
            headers: nil,
            params: params as? [String : Any]
        ) { result in
            switch result{
            case .success(let data):
                do{
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(jsonData)
                }catch{
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateUser(userId:Int,fname:String, lname: String, gen: String, pnumber:String, email: String, address: String){
        let params = ["firstName":fname,
                      "secondName": lname,
                      "gender": gen,
                      "phoneNumber": pnumber,
                      "email": email,
                      "address": address] as NSDictionary
        BioHaazNetworkManager.shared.request(
            method: "PUT",
            url: "\(self.updateUserURL)\(userId)",
            headers: nil,
            params: params as? [String : Any]
        ) { result in
            switch result{
            case .success(let data):
                do{
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(jsonData)
//                    print("User updated successfully")
                }catch{
                    print(error.localizedDescription)
//                    print("User updated catch")
                }
            case .failure(let error):
                print(error)
//                print("User updation failed")
            }
        }
    }
    
    
    func deleteUser(userId:Int){
        BioHaazNetworkManager.shared.request(
            method: "DELETE",
            url: "\(self.deleteUserURL)\(userId)",
            headers: nil,
            params: nil
        ) { result in
            switch result{
            case .success(let data):
                do{
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                    print(jsonData)
                }catch{
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
}
