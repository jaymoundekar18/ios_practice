import Foundation
import BioHaazNetwork

class ApiPlugin: BioHaazPlugin {
    func onRequest(_ request: URLRequest) {
        print(request)
    }
    
    func onResponse(_ response: URLResponse?, data: Data?, error: Error?) {
        print(response as Any)
    }
}
