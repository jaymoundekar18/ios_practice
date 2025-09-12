import Foundation

// MARK: - Simple API Service
class SimpleAPIService {
    
    // MARK: - Step 1: Basic GET Request
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        
        // Step 1: Create URL
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        // Step 2: Create Request
        let request = URLRequest(url: url)
        
        // Step 3: Make Request
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Step 4: Check for Error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Step 5: Check if Data Exists
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }
            
            // Step 6: Convert JSON to Model
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    // MARK: - Step 2: GET Request with ID
    func getUser(id: Int, completion: @escaping (Result<MyUser, Error>) -> Void) {
        
        // Step 1: Create URL with ID
        let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(id)")!
        
        // Step 2: Create Request
        let request = URLRequest(url: url)
        
        // Step 3: Make Request
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Step 4: Check for Error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Step 5: Check if Data Exists
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }
            
            // Step 6: Convert JSON to Model
            do {
                let user = try JSONDecoder().decode(MyUser.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    // MARK: - Step 3: POST Request (Create New Data)
    func createUser(name: String, email: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        // Step 1: Create URL
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        // Step 2: Create Request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Step 3: Create Data to Send
        let newUser = ["name": name, "email": email, "id": 11] as [String : Any]
        
        // Step 4: Convert to JSON Data
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: newUser)
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        // Step 5: Make Request
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Step 6: Check for Error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Step 7: Check if Data Exists
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }
            
            // Step 8: Convert JSON to Model
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    // MARK: - Step 4: Raw JSON Request (Without Models)
    func getUsersRaw(completion: @escaping (Result<[[String: Any]], Error>) -> Void) {
        
        // Step 1: Create URL
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        // Step 2: Create Request
        let request = URLRequest(url: url)
        
        // Step 3: Make Request
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Step 4: Check for Error
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Step 5: Check if Data Exists
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 0, userInfo: nil)))
                return
            }
            
            // Step 6: Convert JSON to Dictionary
            do {
                let jsonArray = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
                completion(.success(jsonArray))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
