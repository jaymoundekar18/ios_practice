//
//  ThirdScreen.swift
//  DemoApp
//
//  Created by Chandra Hasan on 05/06/25.
//

import UIKit

class ThirdScreen: UIViewController {

    
    
    @IBOutlet var reloadBtn: UIButton!
    @IBOutlet var listView: UITableView!
    
    var colors = ["RED", "WHITE", "BLUE","CYAN","YELLOW","PURPLE"]
    var cars = ["BMW", "BENZ", "TATA","MERCEDES","SUZUKI"]
    var bike = ["YAMAHA", "TVS", "HONDA","BAJAJ","KTM","MV","KAWASAKI"]
    var mobile = ["APPLE", "SAMSUNG", "GOOGLE", "REDMI","MOTOROLA"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        listView.delegate = self
        listView.dataSource = self
        
        listView.reloadData()
    }
 
    @IBAction func reload(_ sender: Any) {
        colors = ["RED", "WHITE", "BLUE","CYAN","YELLOW","PURPLE"]
        cars = ["BMW", "BENZ", "TATA","MERCEDES","SUZUKI"]
        bike = ["YAMAHA", "TVS", "HONDA","BAJAJ","KTM","MV","KAWASAKI"]
        mobile = ["APPLE", "SAMSUNG", "GOOGLE", "REDMI","MOTOROLA"]
        listView.reloadData()
        
        print("data reloaded successfully")
    }
    
    
    
    /*
     // remove  vlue
     tblwvies.reload
     */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
}
extension ThirdScreen: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0) {
            colors.count
        } else if (section == 1) {
            cars.count
        }else if (section == 2){
            bike.count
        }else{
            mobile.count
        }
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if(section == 0) {
//            return "COLORS"
//        } else {
//            return "CARS"
//        }
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
        view.backgroundColor = UIColor.systemTeal
        
        let lbl = UILabel()
        lbl.frame = CGRect(x: 30, y: 10, width: tableView.frame.width, height: 50)
        
        if(section == 0) {
            lbl.text = "COLORS"
        } else if (section == 1) {
            lbl.text = "CARS"
        }else if (section == 2){
            lbl.text = "BIKES"
        }else{
            lbl.text = "MOBILE"
        }
        lbl.tintColor = UIColor.black
        
        view.addSubview(lbl)
    
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyTableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2") as! MyTableViewCell2
        if(indexPath.section == 0) {
            cell.myLbl.text = colors[indexPath.row]
        } else if(indexPath.section == 1) {
            cell.myLbl.text = cars[indexPath.row]
        }else if(indexPath.section == 2){
            cell2.mylbl2.text = bike[indexPath.row]
            return cell2
            
        }else{
            cell2.mylbl2.text = mobile[indexPath.row]
            return cell2
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0) {
            print(colors[indexPath.row])
        } else if(indexPath.section == 1){
            print(cars[indexPath.row])
        } else if(indexPath.section == 2){
            print(bike[indexPath.row])
        }else{
            print(mobile[indexPath.row])
        }
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) && (indexPath.section == 0){
            tableView.beginUpdates()
            colors.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }else if (editingStyle == .delete) && (indexPath.section == 1){
            tableView.beginUpdates()
            cars.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }else if (editingStyle == .delete) && (indexPath.section == 2){
            tableView.beginUpdates()
            bike.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }else if (editingStyle == .delete) && (indexPath.section == 3){
            tableView.beginUpdates()
            mobile.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }

}
