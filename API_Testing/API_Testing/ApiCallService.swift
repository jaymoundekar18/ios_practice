import Foundation

class ApiCallService{
    
    func createUser(fname:String, lname: String, gen: String, pnumber:String, email: String, address: String, completion: @escaping ([String: Any]?, Error?) -> Void) {

        
        
        let newUser: [String : Any] = ["firstName":fname,
                       "secondName": lname,
                       "gender": gen,
                       "phoneNumber": pnumber,
                       "email": email,
                       "address": address]
        
        let parameters: [String: Any] = [
            "firstName": fname,
            "lastName": lname,
            "gender": gen,
            "email": email,
            "address": address
        ]

        var request = URLRequest(url: URL(string: "http://3.225.127.58:8080/api/user/create")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         
       
         
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: newUser, options: [])
        } catch {
            print("Error serializing JSON:", error)
        }
         
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error:", error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status Code:", httpResponse.statusCode)
            }
            
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON:", jsonString)
                }
            }
        }
         
        task.resume()
         
    }
}
