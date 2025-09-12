import Foundation

// MARK: - Simple User Model
struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let website: String
}

struct MyUser: Codable{
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: My_Address
    let phone: String
    let website: String
    let company: My_company
}

struct My_Address: Codable{
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: My_geo
}

struct My_company: Codable{
    let name: String
    let catchPhrase: String
    let bs: String
}

struct My_geo: Codable{
    let lat: String
    let lng: String
}


// MARK: - Simple Post Model
struct Post: Codable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

// MARK: - Simple Comment Model
struct Comment: Codable {
    let id: Int
    let name: String
    let email: String
    let body: String
    let postId: Int
}

// MARK: - How to Create Models - Step by Step

/*
 
 STEP 1: Look at the JSON response from API
 Example JSON:
 {
   "id": 1,
   "name": "Leanne Graham",
   "email": "Sincere@april.biz",
   "phone": "1-770-736-8031 x56442",
   "website": "hildegard.org"
 }
 
 STEP 2: Create a struct that matches the JSON
 struct User: Codable {
     let id: Int
     let name: String
     let email: String
     let phone: String
     let website: String
 }
 
 STEP 3: Make sure property names match JSON keys exactly
 - JSON key "id" = Swift property "id" ✅
 - JSON key "name" = Swift property "name" ✅
 - JSON key "email" = Swift property "email" ✅
 
 STEP 4: Use correct data types
 - JSON number = Swift Int or Double
 - JSON string = Swift String
 - JSON boolean = Swift Bool
 - JSON array = Swift Array
 - JSON object = Swift struct
 
 STEP 5: Add Codable protocol
 - Codable = Can convert to/from JSON automatically
 - No extra code needed!
 
 */

// MARK: - Model with Different Property Names
struct UserWithCustomNames: Codable {
    let userId: Int
    let fullName: String
    let emailAddress: String
    
    // Use CodingKeys to map JSON keys to different property names
    enum CodingKeys: String, CodingKey {
        case userId = "id"           // JSON "id" maps to Swift "userId"
        case fullName = "name"       // JSON "name" maps to Swift "fullName"
        case emailAddress = "email"  // JSON "email" maps to Swift "emailAddress"
    }
}

// MARK: - Model with Nested Objects
struct UserWithAddress: Codable {
    let id: Int
    let name: String
    let email: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
    let zipcode: String
}

/*
 
 Example JSON with nested object:
 {
   "id": 1,
   "name": "Leanne Graham",
   "email": "Sincere@april.biz",
   "address": {
     "street": "Kulas Light",
     "city": "Gwenborough",
     "zipcode": "92998-3874"
   }
 }
 
 */

// MARK: - Model with Array
struct UserWithPosts: Codable {
    let id: Int
    let name: String
    let posts: [Post]
}

/*
 
 Example JSON with array:
 {
   "id": 1,
   "name": "Leanne Graham",
   "posts": [
     {
       "id": 1,
       "title": "Post 1",
       "body": "This is post 1"
     },
     {
       "id": 2,
       "title": "Post 2",
       "body": "This is post 2"
     }
   ]
 }
 
 */

// MARK: - Optional Properties
struct UserWithOptionalFields: Codable {
    let id: Int
    let name: String
    let email: String
    let phone: String?        // Optional - might be missing from JSON
    let website: String?      // Optional - might be missing from JSON
}

/*
 
 Use optional properties when:
 - JSON field might be missing
 - JSON field might be null
 - You want to handle missing data gracefully
 
 */

// MARK: - Simple Helper Methods
extension User {
    
    // Add helper methods to your models
    func getDisplayName() -> String {
        return "\(name) (ID: \(id))"
    }
    
    func isValidEmail() -> Bool {
        return email.contains("@")
    }
}

extension Post {
    
    func getShortTitle() -> String {
        if title.count > 20 {
            return String(title.prefix(20)) + "..."
        }
        return title
    }
}
