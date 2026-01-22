import Foundation


class NetworkManager: ObservableObject{
    
    @Published var posts = [MyData]()
    
    func fetchData(){
        if let url = URL(string: " "){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data{
                        do{
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        }
                        catch{
                            print(error)
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
    
}
