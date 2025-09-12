//
//  ThirdViewController.swift
//  Company app
//
//  Created by Prabhakar Bunga on 02/09/25.
//

import UIKit

class ThirdViewController: UIViewController, UITextFieldDelegate {

    let apiService = SimpleAPIService()

    
    @IBOutlet weak var selectSeg: UISegmentedControl!
    
    
    @IBOutlet weak var idField: UITextField!
    
    @IBOutlet weak var showDataView: UIView!
    
    @IBOutlet weak var showBtn: UIButton!
    
    
    @IBOutlet weak var existingDataView: UIView!
    
    @IBOutlet weak var showLabel: UILabel!
//    
    @IBOutlet weak var createView: UIView!
    
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var createUserResult: UILabel!
//
    
    @IBOutlet weak var dispExistingLabel: UILabel!
    
    @IBOutlet weak var showExistingBtn: UIButton!
    
    
    
    @IBOutlet weak var createUserBtn: UIButton!
    
    @IBOutlet weak var clearBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.existingDataView.isHidden = true
        self.createView.isHidden = true
        
        self.idField.delegate = self
        self.userName.delegate = self
        self.userEmail.delegate = self
        
        self.selectSeg.insertSegment(withTitle: "Show Existing", at: 2, animated: true)
        
        self.selectSeg.backgroundColor = UIColor(red: 236/255.0, green: 237/255.0, blue: 255/255.0, alpha: 1.0)
        self.selectSeg.selectedSegmentIndex = 1
        self.changeSegView(self.selectSeg as Any)
    }
    
    
    
    @IBAction func changeSegView(_ sender: Any) {
        if selectSeg.selectedSegmentIndex == 0{
            self.selectSeg.selectedSegmentTintColor = UIColor(red: 209/255.0, green: 189/255.0, blue: 255/255.0, alpha: 1.0)
            self.existingDataView.isHidden = true
            self.createView.isHidden = true
            self.showDataView.isHidden = false
            self.idField.endEditing(true)
            self.userName.endEditing(true)
            self.userEmail.endEditing(true)
            
        }
        else if selectSeg.selectedSegmentIndex == 1{
            self.selectSeg.selectedSegmentTintColor = UIColor(red: 136/255.0, green: 255/255.0, blue: 251/255.0, alpha: 1.0)
            self.existingDataView.isHidden = true
            self.createView.isHidden = false
            self.showDataView.isHidden = true
            self.idField.endEditing(true)
            self.userName.endEditing(true)
            self.userEmail.endEditing(true)
        }
        else{
            self.selectSeg.selectedSegmentTintColor = UIColor(red: 241/255.0, green: 9/255.0, blue: 0/255.0, alpha: 0.68)

            self.existingDataView.isHidden = false
            self.createView.isHidden = true
            self.showDataView.isHidden = true
            self.idField.endEditing(true)
            self.userName.endEditing(true)
            self.userEmail.endEditing(true)
        }
    }
    
    
    
    @IBAction func showDataAct(_ sender: Any) {
        self.idField.endEditing(true)
        
        let idText = self.idField.text ?? ""
        let idNumber = Int(idText) ?? 0
        self.app_GetSingleUser(uid: idNumber)
        self.idField.text = ""
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == idField{
            self.idField.endEditing(true)
            
            let idText = self.idField.text ?? ""
            let idNumber = Int(idText) ?? 0
            self.app_GetSingleUser(uid: idNumber)
            self.idField.text = ""
        }
        else if textField == userName{
            self.userName.endEditing(true)
            self.userEmail.becomeFirstResponder()
        }
        else if textField == userEmail{
            self.userEmail.endEditing(true)
        }
        return true
    }
    
    
    
    @IBAction func dispExtData(_ sender: Any) {
        
//        print("Exsting page print")
        self.app_GetAllUsers()
    }
    
    
    @IBAction func createUserAct(_ sender: Any) {
        self.createUserResult.text = "\(self.userName.text!)  \(self.userEmail.text!)"
//        self.createUserResult.text = "✅ User Created Successfully"
//        self.app_CreateUser(uname: "Alex Muller", uemail: "alexmuller@onsg.co")
        self.app_CreateUser(uname: self.userName.text!, uemail: self.userEmail.text!)
        print(self.userName.text!, self.userEmail.text!)
        
        self.userName.text = ""
        self.userEmail.text = ""
        
        
    }
    
    
    @IBAction func clearBtnAct(_ sender: Any) {
        self.showLabel.text = ""
        self.dispExistingLabel.text = ""
        self.userName.text = ""
        self.userEmail.text = ""
        self.createUserResult.text = ""
    }
    
    
    
    func app_GetAllUsers() {
        var userData : String = ""
        apiService.getUsers { result in
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
//                    print("✅ Success! Found \(users.count) users \n\n")
                    userData += "✅ Success! Found \(users.count) users \n\n"
                    
                    for user in users {
                        userData += "🆔 \(user.id): 👤 \(user.name) - ✉️ \(user.email) \n\n"
                    }
//                    print(userData)
                    self.dispExistingLabel.textAlignment = .left
                    self.dispExistingLabel.text = userData
                }
            
            case .failure(let error):
                DispatchQueue.main.async {
                    self.dispExistingLabel.textAlignment = .center
//                    print("❌ Error: \(error.localizedDescription)")
                    self.dispExistingLabel.text = "❌ Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    
    func app_GetSingleUser(uid: Int){
        
        apiService.getUser(id: uid) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
//                    print("✅ Success! Found user: \(uid)")
//                    print("👤 Name: \(user.name)")
//                    print("📧 Email: \(user.email)")
//                    print("📱 Phone: \(user.phone)")
//                    print("🌐 Website: \(user.website)")
                    print(user)
                    self.showLabel.textAlignment = .left
                    self.showLabel.text = """
                                ✅ Success! User Found :
                                
                                
                                🆔 : \(uid)  \n
                                👤 Name: \(user.name) \n
                                📧 Email: \(user.email) \n
                                📱 Phone: \(user.phone) \n
                                🌐 Website: \(user.website) \n
                                🏠 Address: \(user.address.suite), \(user.address.street), \(user.address.city), \(user.address.zipcode). \n
                                📍 Latitude: \(user.address.geo.lat), Longitude: \(user.address.geo.lng) \n
                                💻 Company: \(user.company.name) , \(user.company.catchPhrase).\n
                                """
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
//                    print("❌ Error: \(error.localizedDescription)")
                    self.showLabel.textAlignment = .center
                    self.showLabel.text = "❌ Error: \n\n \(error.localizedDescription)"
                }
            }
        }
    }
    
    
    func app_CreateUser(uname:String, uemail:String) {
        
        apiService.createUser(name: uname, email: uemail) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async{
//                print("✅ Success! Created user:")
//                print("👤 Name: \(user.name)")
//                print("📧 Email: \(user.email)")
                self.createUserResult.textAlignment = .left
                self.createUserResult.text = """
                                ✅ Success! Created user: \n\n
                                👤 Name: \(user.name) \n\n
                                📧 Email: \(user.email)
                                """
            }
            
            case .failure(let error):
                DispatchQueue.main.async {
                    self.createUserResult.textAlignment = .center
//                    print("❌ Error: \(error.localizedDescription)")
                    self.createUserResult.text = "❌ Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.idField.endEditing(true)
        self.userName.endEditing(true)
        self.userEmail.endEditing(true)
    }

}
