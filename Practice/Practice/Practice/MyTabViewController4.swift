//
//  MyTabViewController4.swift
//  Practice
//
//  Created by Chandra Hasan on 16/06/25.
//

import UIKit

class MyTabViewController4: UIViewController {

    @IBOutlet var myTableView: UITableView!
    @IBOutlet var settingIcon: UITabBarItem!
    
    let settingList = ["General", "Network & Wireless", "Sound & Haptics", "Privacy & Security", "Accessibility", "Other Settings"]
    
    let generalList = ["About","Software Update","AirDrop & Handoff","VPN & Device Management","Date & Time","Language & Region","Transfer or Reset iPhone"]
    
    let networkList = ["Wi-Fi","Cellular","Personal Hotspot","VPN"]
    
    let soundList = ["Sounds", "Haptics", "Ringtone & Alert Tone"]
    
    let privacyList = ["Location Services","Contacts","Calenders","Reminders","Photos"]
    
    let accessList = ["Vision", "Hearing" ,"Physical Monitor"]
    
    let otherList = ["Siri", "Screen Time", "Apple Pay", "TV Provider"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MyTabViewController4: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        settingList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return generalList.count
        }
        else if(section == 1){
            return networkList.count
        }
        else if(section == 2){
            return soundList.count
        }
        else if(section == 3){
            return privacyList.count
        }
        else if(section == 4){
            return accessList.count
        }
        else{
            return otherList.count
        }
            
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleView = UIView()
        titleView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        titleView.backgroundColor = UIColor.white
        
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 20, y: 0, width: tableView.frame.width, height: 50)
        titleLabel.font = titleLabel.font.withSize(24)
        
        if(section == 0) {
            titleLabel.text = settingList[0]
        } else if(section == 1){
            titleLabel.text = settingList[1]
        }
        else if(section == 2){
            titleLabel.text = settingList[2]
        }
        else if(section == 3){
            titleLabel.text = settingList[3]
        }
        else if(section == 4){
            titleLabel.text = settingList[4]
        }
        else{
            titleLabel.text = settingList[5]
        }
        
        titleLabel.tintColor = UIColor.black
        
        titleView.addSubview(titleLabel)
        
        return titleView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingCell = tableView.dequeueReusableCell(withIdentifier: "settingCell") as! SettingTableViewCell
        if(indexPath.section == 0) {
            settingCell.contentLabel.text = generalList[indexPath.row]
            
        } else if(indexPath.section == 1){
            settingCell.contentLabel.text = networkList[indexPath.row]
        }
        else if(indexPath.section == 2){
            settingCell.contentLabel.text = soundList[indexPath.row]
        }
        else if(indexPath.section == 3){
            settingCell.contentLabel.text = privacyList[indexPath.row]
        }
        else if(indexPath.section == 4){
            settingCell.contentLabel.text = accessList[indexPath.row]
        }
        else{
            settingCell.contentLabel.text = otherList[indexPath.row]
        }
        
        
        return settingCell
    }
    
}
