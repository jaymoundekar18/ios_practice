import Foundation

struct UsersData: Hashable ,Codable, Identifiable{
    let id: Int
    let firstName: String?
    let secondName:  String?
    let gender: String?
    let phoneNumber: String?
    let email: String?
    let address: String?
}

