import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var clockInLabel: UILabel!
    
    @IBOutlet weak var commLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var timerButton: UIButton!
    
    @IBOutlet weak var dateTimePicker: UIDatePicker!
    
    
    var timerFlag : Bool = true
    
    var timer: Timer?
    
    var counter = 0
    var seconds = 0
    var minutes = 0
    var hours = 0
    
    var currentTime: String = ""
    var userSelectedTime: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func timerStartStopAct(_ sender: Any) {
        
        if self.timerFlag {
            self.timerButton.setTitle("Stop", for: .normal)
            self.timerFlag = false
            self.commLabel.text = "Working time Started"
            self.clockInLabel.text = ""
            
            print(self.dateTimePicker.date)
            
            self.getWorkingTimeDiff()
            
            print("Timer Started")
            self.startTimer()
        }
        else{
            self.timerButton.setTitle("Start", for: .normal)
            self.timerFlag = true
            self.commLabel.text = "Working time Stopped !!"
            self.clockInLabel.text = "Your work time \(self.hours)hrs \(self.minutes)mins"
            
            print("Timer Stopped")
            self.stopTimer()
        }
    }
    
    func startTimer(){
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func stopTimer(){
        self.timer?.invalidate()
        self.timer = nil
        self.counter = 0
        self.hours = 0
        self.minutes = 0
        self.seconds = 0
        self.timerLabel.text = "00:00:00"
    }
    
    @objc func updateTimer(){
        self.counter += 1
        
        self.seconds = self.counter % 60
        self.minutes = (counter % 3600) / 60
        self.hours = counter / 3600
        
        self.timerLabel.text = String(format: "%02d:%02d:%02d", self.hours, self.minutes, self.seconds)
    }
    
    func dateConversion(usrDate: Date) -> String{

        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        let convertedDate = formatter.string(from: usrDate)
        
        return convertedDate
    }
    
    func getWorkingTimeDiff(){
        let date = Date()
        
        let calender = Calendar.current
        let components = calender.dateComponents([.hour, .minute, .second], from: self.dateTimePicker.date, to: date)
        if let hrs = components.hour,
           let mins = components.minute,
           let sec = components.second {
            print("diff time:  \(hrs) \(mins) \(sec)")
            
//            self.hours = hrs
//            self.minutes = mins
//            self.seconds = sec
//            self.counter = sec
            
            var total_seconds = hrs * 3600
            total_seconds += mins * 60
            total_seconds += sec
            
            self.counter = total_seconds
            
            print("total seconds: ", total_seconds)
        }
    }
    
    
}
