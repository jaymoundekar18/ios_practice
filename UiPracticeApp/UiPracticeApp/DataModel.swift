import Foundation

struct Results: Decodable{
    let hits: [MyData]
}

struct MyData: Decodable, Identifiable{
    var id: String{
            return objectID
        }
    let objectID: String
    let title: String?
    let url: String?
    let author: String?
}
