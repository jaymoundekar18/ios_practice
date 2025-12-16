
import UIKit
import BioHaazNetwork
import Network


class ViewController: UIViewController, UITextFieldDelegate{

    let apiCallService = ApiCallService()
    
    var currentAction = ""
    
    let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkMonitorQueue")
        
    var isNetwork = false
    
    @IBOutlet weak var networklabel: UILabel!
    
    @IBOutlet weak var processQueue: UILabel!
    
    @IBOutlet weak var processActionLbl: UILabel!
    
    
    @IBOutlet weak var reloadBtn: UIButton!
    
    @IBOutlet weak var showUserView: UIView!
    
    
    @IBOutlet weak var myscrollView: UIScrollView!
    
    @IBOutlet weak var showUserLabel: UILabel!
    
    @IBOutlet weak var userDataView: UIView!
    
    @IBOutlet weak var userDataLabel: UILabel!
    
    
    @IBOutlet weak var createUserView: UIView!
    
    
    @IBOutlet weak var submitNewUserBtn: UIButton!
    
    
    @IBOutlet weak var updateNewUserBtn: UIButton!
    
    
    @IBOutlet weak var userDatatn: UIButton!
    
    
    @IBOutlet weak var createUpdateSeg: UISegmentedControl!
    
    @IBOutlet weak var updateUserIdField: UITextField!
    
    
    @IBOutlet weak var userDataIdField: UITextField!
    
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var address: UITextField!
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var msgLabel: UILabel!

    @IBOutlet weak var deleteUserView: UIView!
    
    @IBOutlet weak var delUserField: UITextField!
    
    @IBOutlet weak var segmentSelect: UISegmentedControl!
    
    override func viewDidAppear(_ animated: Bool) {
        self.updateQueueCount()
        self.reloadQueue(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startMonitoring()
        self.updateQueueCount()
        self.processActionLbl.text = ""
        reloadBtn.setTitle("", for: .normal)

        
        print("-------VIEW LOADED-------")
        UNUserNotificationCenter.current().delegate = self
        self.registerLocal()
        
        self.segmentSelect.selectedSegmentIndex = 0
        self.createUpdateSeg.selectedSegmentIndex = 0
        
        self.updateUserIdField.isHidden = true
        self.updateNewUserBtn.isHidden = true
        
        self.userDataView.isHidden = true
        self.createUserView.isHidden = true
        self.deleteUserView.isHidden = true
        self.phoneNumber.delegate = self
        self.userDataIdField.delegate = self
        self.firstName.delegate = self
        self.lastName.delegate = self
        self.gender.delegate = self
        self.emailAddress.delegate = self
        self.address.delegate = self
        self.delUserField.delegate = self
        self.updateUserIdField.delegate = self
        
        self.impactGenerator.prepare()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.gender.isUserInteractionEnabled = false
        if(NetworkCalls.shared.initilizedFramework()) {
            print("BioHaaz Network init success")
            print("User updated from view ")
        } else {
            print("BioHaaz Network init failed")
        }
        
        
        
        let swipeGesture_Right = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        swipeGesture_Right.direction = .right
        view.addGestureRecognizer(swipeGesture_Right)
        
        let swipeGesture_Left = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        swipeGesture_Left.direction = .left
        view.addGestureRecognizer(swipeGesture_Left)
        
    }

    @objc func handleGesture(_ gesture: UISwipeGestureRecognizer){
        var currSegIndex = segmentSelect.selectedSegmentIndex
        let maxSegIndex = segmentSelect.numberOfSegments - 1
            
        switch gesture.direction{
        case .left:
            if currSegIndex < maxSegIndex {
                currSegIndex += 1
                    }
            print("swiped left")
            
        case .right:
            if currSegIndex > 0 {
                currSegIndex -= 1
                    }
            print("swiped right")
            
        default:
            print("swip didn't worked")
            self.processActionLbl.text = "swip didn't worked"
        }
        
        segmentSelect.selectedSegmentIndex = currSegIndex
        segmentSelect.sendActions(for: .valueChanged)
        
    }
    
    
    @IBAction func cahngeSegment(_ sender: Any) {
        self.dismissAllFields()
        if self.segmentSelect.selectedSegmentIndex == 0 {
            print("-------Show User Segment-------")
            self.showUserView.isHidden = false
            self.userDataView.isHidden = true
            self.createUserView.isHidden = true
            self.deleteUserView.isHidden = true
        }
        else if self.segmentSelect.selectedSegmentIndex == 1 {
            print("-------User Data Segment-------")
            self.showUserView.isHidden = true
            self.userDataView.isHidden = false
            self.createUserView.isHidden = true
            self.deleteUserView.isHidden = true
            
        }
        else if self.segmentSelect.selectedSegmentIndex == 2{
            print("-------Create/Update User Segment-------")
            self.showUserView.isHidden = true
            self.userDataView.isHidden = true
            self.createUserView.isHidden = false
            self.deleteUserView.isHidden = true
            
        }
        else{
            print("-------Delete User Segment-------")
            self.showUserView.isHidden = true
            self.userDataView.isHidden = true
            self.createUserView.isHidden = true
            self.deleteUserView.isHidden = false
            
        }
    }
    
    @IBAction func createUpdateSegAction(_ sender: Any) {
        if self.createUpdateSeg.selectedSegmentIndex == 0{
            self.currentAction = "CREATE_USER"
            
            print("-------Create User Segment-------")
            self.submitNewUserBtn.isHidden = false
            self.updateUserIdField.isHidden = true
            self.updateNewUserBtn.isHidden = true
            
        }
        else{
            self.currentAction = "UPDATE_USER"
            
            print("-------Update User Segment-------")
            self.updateUserIdField.isHidden = false
            self.updateNewUserBtn.isHidden = false
            self.submitNewUserBtn.isHidden = true
        }
    }
    
    
    @IBAction func userDataAction(_ sender: Any) {
        
        self.impactGenerator.impactOccurred()
    
        
        self.currentAction = "SHOW_SINGLE_USER"
        
        self.dismissAllFields()
        if self.userDataIdField.text != ""{
            
            let idText = self.userDataIdField.text ?? ""
            let idNumber = Int(idText) ?? 0
            
            var dispData = ""
            
            NetworkCalls.shared.getSingleUsers(userId: idNumber){ result, error in
                DispatchQueue.main.async {
                    if result != nil{
                        print("Show User result is : ",result!)
                        dispData = """
                                ✅ Success! User Found: \n\n
                                🆔 : \(result!.id) \n\n
                                👤 Name: \(result?.firstName ?? "") \(result?.secondName ?? "") \n\n
                                📧 Email: \(result!.email ?? "") \n\n
                                📞 Phone number: \(result!.phoneNumber ?? "") \n\n
                                🏠 Address: \(result!.address ?? "")
                                """
                    }
                    else{
                        print("Show user error : ",error!.localizedDescription)
                        dispData = "❌ Error : User Not Found \n or \n \(error!.localizedDescription)"
                    }
                    
                    self.userDataLabel.text = "\(dispData)"
                }
            }
        }else{
            self.currentAction = "SHOW_SINGLE_USER_ERROR"
            self.scheduleLocalNoti()
        }
        
        
    }
    
    
    @IBAction func showUsers(_ sender: Any) {
        self.currentAction = "SHOW_ALL_USER"
        
        print("Get all users data")
        var allUsers = ""
        NetworkCalls.shared.getAllUsers(){ result, error in
            DispatchQueue.main.async {
                if result != nil{
                    print("Show User result is : ",result!)
                    for user in result! {
                        print(user.firstName as Any)
                        allUsers += "🆔 \(user.id): 👤 \(user.firstName ?? "")  📧 \(user.email ?? "")\n"
                        
                    }
                }
                else{
                    print("Show user error : ",error!.localizedDescription)
                    self.processActionLbl.text = "❌ Failed : \(error!.localizedDescription)"
                }
                self.processActionLbl.text = ""
                self.showUserLabel.text = allUsers
                
            }
        }
        
        
    }
    
    
    
    
    
    @IBAction func submitNewUser(_ sender: Any) {
//        self.currentAction = "CREATE_USER"
        
        print("Submit button pressed")
      
        if (self.firstName.text != "") && (self.lastName.text != "") && (self.gender.text != "") && (self.phoneNumber.text != "") && (self.emailAddress.text != "") && (self.address.text != ""){
            
            let alertSheet = UIAlertController(title: "Are you sure want to Create Account ", message: "", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Yes", style: .default){ action in
                NetworkCalls.shared.createUser(fname:self.firstName.text!, lname: self.lastName.text!, gen: self.gender.text!, pnumber: self.phoneNumber.text!, email: self.emailAddress.text!, address: self.address.text!)
                
                print("User Created Successfully")
                self.updateQueueCount()
                self.scheduleLocalNoti()
                self.firstName.text = ""
                self.lastName.text = ""
                self.gender.text = ""
                self.phoneNumber.text = ""
                self.emailAddress.text = ""
                self.address.text = ""
            }
            
            alertSheet.addAction(confirmAction)
            
            let denyAction = UIAlertAction(title: "Cancel", style: .destructive) { action in
                self.dismiss(animated: true)
            }
            alertSheet.addAction(denyAction)
            
            self.dismissAllFields()
            
            self.present(alertSheet, animated: true)
            
        }
        else{
            self.currentAction = "CREATE_USER_ERROR"
            self.scheduleLocalNoti()
        }
    }
    
    @IBAction func updateExsUser(_ sender: Any) {
        print("Update button pressed")
//        self.currentAction = "UPDATE_USER"
//        
        if (self.updateUserIdField.text != "") && (self.firstName.text != "") && (self.lastName.text != "") && (self.gender.text != "") && (self.phoneNumber.text != "") && (self.emailAddress.text != "") && (self.address.text != "") {
            
            
            let idText = self.updateUserIdField.text ?? ""
            let idNumber = Int(idText) ?? 0
            print(idNumber)
            
            
            let alertSheet = UIAlertController(title: "Are you sure want to Update the Account ", message: "", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Yes", style: .default){ action in
                NetworkCalls.shared.updateUser(userId: idNumber ,fname:self.firstName.text!, lname: self.lastName.text!, gen: self.gender.text!, pnumber: self.phoneNumber.text!, email: self.emailAddress.text!, address: self.address.text!)
                
                self.scheduleLocalNoti()
                self.updateQueueCount()
                
                self.updateUserIdField.text = ""
                self.firstName.text = ""
                self.lastName.text = ""
                self.gender.text = ""
                self.phoneNumber.text = ""
                self.emailAddress.text = ""
                self.address.text = ""
                
            }
            alertSheet.addAction(confirmAction)
            
            let denyAction = UIAlertAction(title: "Cancel", style: .destructive) { action in
                self.dismiss(animated: true)
            }
            alertSheet.addAction(denyAction)
            
            self.dismissAllFields()
            
            self.present(alertSheet, animated: true)
            
        }
        else{
            self.currentAction = "UPDATE_USER_ERROR"
            self.scheduleLocalNoti()
            
        }
    }
    
    
    
    
    @IBAction func delUserAction(_ sender: Any) {
        
        self.currentAction = "DELETE_USER"
        
        if self.delUserField.text != ""{
            
            let idText = self.delUserField.text ?? ""
            let idNumber = Int(idText) ?? 0
            
            let alertSheet = UIAlertController(title: "Are you sure want to DELETE User:\(idNumber) ? ", message: "", preferredStyle: .alert)
            
            let yes_alertAction = UIAlertAction(title: "Yes", style: .default) { action in
                
                NetworkCalls.shared.deleteUser(userId: idNumber)
                print("user \(idNumber) deleted")
                self.updateQueueCount()
                self.scheduleLocalNoti()
                self.delUserField.text = ""
            }
            alertSheet.addAction(yes_alertAction)
            
            let cancel_alertAction = UIAlertAction(title: "Cancel", style: .destructive) { action in
                self.dismiss(animated: true)
            }
            alertSheet.addAction(cancel_alertAction)
            
            self.delUserField.endEditing(true)
            self.present(alertSheet, animated: true)
        }
        else{
            self.currentAction = "DELETE_USER_Error"
            self.scheduleLocalNoti()
        }
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.msgLabel.text = ""
        self.dismissAllFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstName {
            self.firstName.endEditing(true)
            self.lastName.becomeFirstResponder()
        }
        else if textField == lastName {
            self.lastName.endEditing(true)
            self.gender.becomeFirstResponder()
        }
        else if textField == gender {
            self.gender.endEditing(true)
            self.emailAddress.becomeFirstResponder()
        }
        else if textField == emailAddress{
            self.emailAddress.endEditing(true)
            self.address.becomeFirstResponder()
        }
        else if textField == address{
            self.address.endEditing(true)
            self.phoneNumber.becomeFirstResponder()
        }
        else if textField == phoneNumber{
            self.phoneNumber.endEditing(true)
            if self.createUpdateSeg.selectedSegmentIndex == 0{
                submitNewUser(self)
            }
            if self.createUpdateSeg.selectedSegmentIndex == 1{
                updateExsUser(self)
            }
            
        }
        else if textField == userDataIdField{
            self.userDataIdField.endEditing(true)
            userDataAction(self)
        }
        else if textField == delUserField{
            self.delUserField.endEditing(true)
        }
        else if textField == updateUserIdField{
            if self.isNetwork{
                DispatchQueue.main.async{
                    let idText = self.updateUserIdField.text ?? ""
                    let idNumber = Int(idText) ?? 0
                    NetworkCalls.shared.getSingleUsers(userId: idNumber){ result, error in
                        DispatchQueue.main.async {
                            if result != nil{
                                print("Show User result is : ",result!)
                                self.firstName.text = result?.firstName ?? ""
                                self.lastName.text = result?.secondName ?? ""
                                self.gender.text =  result!.gender ?? ""
                                self.emailAddress.text = result!.email ?? ""
                                self.address.text =  result!.address ?? ""
                                self.phoneNumber.text = result!.phoneNumber ?? ""

                            }
                            else{
                                print("Show user error : ",error!.localizedDescription)
                                self.processActionLbl.text = "❌ Error : User Not Found \n or \n \(error!.localizedDescription)"
                            }
                        }
                    }
                }
            }
            else{
                self.processActionLbl.text = "❌ Error : Couldn't fetch the user data"
            }
            
            self.updateUserIdField.endEditing(true)
            self.firstName.becomeFirstResponder()
            
        }
        return true
    }
    

    
    func dismissAllFields(){
        self.updateUserIdField.endEditing(true)
        self.userDataIdField.endEditing(true)
        self.firstName.endEditing(true)
        self.lastName.endEditing(true)
        self.gender.endEditing(true)
        self.emailAddress.endEditing(true)
        self.address.endEditing(true)
        self.phoneNumber.endEditing(true)
        self.delUserField.endEditing(true)
    }
    
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                
                if path.status == .satisfied {
                    
                    if path.isExpensive {
                        self.networklabel.text = "Network : Online - Cellular"
                        self.networklabel.textColor = .systemGreen
                        self.isNetwork = true
                    } else {
                        self.networklabel.text = "Network : Online - WiFi"
                        self.networklabel.textColor = .systemGreen
                        self.isNetwork = true
                    }
                } else {
                    self.networklabel.text = "Network : Offline - No Internet Connection"
                    self.networklabel.textColor = .systemRed
                    self.isNetwork = false
                }
                self.updateQueueCount()
            }
        }
        monitor.start(queue: queue)
        
    }
    deinit {
        monitor.cancel()
    }
    
    private func updateQueueCount() {
        let status = BioHaazNetworkManager.shared.getOfflineQueueStatus()
        let queueCount = status["offlineRequestsCount"] as? Int ?? 0
        processQueue?.text = "Queue: \(queueCount) requests"
        processQueue?.textColor = queueCount > 0 ? .systemOrange : .systemGray
        
//        self.processActionLbl.text = "CurrQueueCount: \(queueCount)"5
    }
    
    @IBAction func clearQueueAct(_ sender: Any) {
        
        let queueStatus = BioHaazNetworkManager.shared.checkOfflineQueueStatus()
        let queueCount = queueStatus.count
        self.processActionLbl.text = "queueCount: \(queueCount)"
        print("queueCount: ", queueCount)
        let result = BioHaazNetworkManager.shared.clearOfflineQueue()
        
        switch result {
        case .success:
            self.processActionLbl.text = "Queue cleared successfully"
            updateQueueCount()
            
        case .failure(let error):
            self.processActionLbl.text = "Failed to clear queue \(error.localizedDescription)"
        }
        
        self.processActionLbl.textColor = .black
        print("clearQueueAct")
    }
    
    
    @IBAction func reloadQueue(_ sender: Any) {
        print("Queue reload pressed")
        let count = BioHaazOfflineQueue.shared.getQueueCount()
        print("Current queue count : ",count)
        self.processActionLbl.text = "Current queue count : \(count)"
        self.processActionLbl.textColor = .black
//        self.updateQueueCount()
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.gender.isUserInteractionEnabled = true
        if textField == gender{
            getGender()
        }
    }
    
    func getGender(){
        let alertSheet = UIAlertController(title: "GENDER", message: "", preferredStyle: .alert)
        
        let male_alertAction = UIAlertAction(title: "MALE", style: .default) { action in
            self.gender.text = "MALE"
            self.emailAddress.becomeFirstResponder()
        }
        alertSheet.addAction(male_alertAction)
        
        let female_alertAction = UIAlertAction(title: "FEMALE", style: .default) { action in
            self.gender.text = "FEMALE"
            self.emailAddress.becomeFirstResponder()
        }
        alertSheet.addAction(female_alertAction)
        
        let pnts_alertAction = UIAlertAction(title: "PREFER NOT TO SAY", style: .default) { action in
            self.gender.text = "PREFER_NOT_TO_SAY"
            self.emailAddress.becomeFirstResponder()
        }
        alertSheet.addAction(pnts_alertAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { action in
            self.dismiss(animated: true)
        }
        alertSheet.addAction(cancelAction)
        
        self.present(alertSheet, animated: true)
        self.emailAddress.becomeFirstResponder()
    }
    
    
}


extension ViewController: UNUserNotificationCenterDelegate{
    
    @objc func registerLocal(){
        let notiCenter = UNUserNotificationCenter.current()
        notiCenter.requestAuthorization(options: [.alert, .badge, .sound]){(granted, error) in
            if granted{
                print("Nofication Access granted")
            }
            else{
                print("Nofication Access Denied")
            }
        }
    }
    
    @objc func scheduleLocalNoti(){
        let notiContent = UNMutableNotificationContent()
        
        if self.currentAction == "CREATE_USER"{
            notiContent.title = "\(self.firstName.text!)! your account is created"
            notiContent.body = "Data has been uploaded successfully."
            
        }
        else if self.currentAction == "DELETE_USER"{
            notiContent.title = "Account Deleted"
            notiContent.body = "All Data of the user has been Deleted Successfully."
        }
        else if self.currentAction == "UPDATE_USER"{
            notiContent.title = "\(self.firstName.text!) User Data Updated"
            notiContent.body = "Data of the user has been Updated Successfully."
        }
        else if self.currentAction == "SHOW_SINGLE_USER_ERROR"{
            notiContent.title = "User ID Error"
            notiContent.body = "Please provide the User ID."
            
            self.processActionLbl.text = "Please provide the user ID."
            self.processActionLbl.textColor = .systemRed
        }
        else if self.currentAction == "DELETE_USER_Error"{
            notiContent.title = "User ID Error"
            notiContent.body = "Please provide the User ID."
            
            self.processActionLbl.text = "Please provide the user data."
            self.processActionLbl.textColor = .systemRed
        }
        else if self.currentAction == "UPDATE_USER_ERROR"{
            notiContent.title = "Data Error!"
            notiContent.body = "Please provide all the user data.\nAll fields are required."
            
            self.processActionLbl.text = "Please provide all the user data.\nAll fields are required."
            self.processActionLbl.textColor = .systemRed
        }
        else if self.currentAction == "CREATE_USER_ERROR"{
            notiContent.title = "Data Error!"
            notiContent.body = "Please provide all the user data.\nAll fields are required."
            
            self.processActionLbl.text = "Please provide all the user data.\nAll fields are required."
            self.processActionLbl.textColor = .systemRed
        }
        
        let notiTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let notiRequest = UNNotificationRequest(identifier: UUID().uuidString, content: notiContent, trigger: notiTrigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(notiRequest)
        
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
