import Foundation
import BioHaazNetwork

class ApiTracker: BioHaazPerformanceTracker{
    func track(request: URLRequest, duration: TimeInterval, success: Bool, speed: Double?) {
        print("tracker")
    }
}
