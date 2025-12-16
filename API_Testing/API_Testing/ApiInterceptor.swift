import Foundation
import BioHaazNetwork

class ApiInterceptor: BioHaazInterceptor{
    
    func intercept(_ request: URLRequest) -> URLRequest {
        var req = request
        req.setValue("MyValue", forHTTPHeaderField: "X-My-Header")
        return req
    }
    func intercept(_ response: URLResponse?, data: Data?, error: Error?) {
        print("t2")
    }
}
