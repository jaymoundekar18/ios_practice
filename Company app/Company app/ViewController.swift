//
//  ViewController.swift
//  Company app
//
//  Created by Chandra Hasan on 12/06/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var stepperBtn: UIStepper!
    
    @IBOutlet var numLabel: UILabel!
    
    @IBOutlet var numSlider: UISlider!
    
    @IBOutlet var progressBar: UIProgressView!
    
    @IBOutlet var itemPicker: UIPickerView!
    
    @IBOutlet var submitBtn: UIButton!
    
    var itemMonth = [String]()
    var itemDay = [String]()
    var itemYear = [String]()
    
    
//    self.progressBar.transform = self.progressBar.transform.scaledBy(x: 1, y: 8)
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        numLabel.text = String(Int(stepperBtn.value))
        numLabel.text = String(Int(numSlider.value))
        progressBar.progress = 0.2
        progressBar.transform = self.progressBar.transform.scaledBy(x: 1, y: 4)
//        numSlider.transform = self.numSlider.transform.rotated(by: -(CGFloat.pi / 2))
        
        itemMonth = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        
        itemDay = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]
        
        itemYear = ["1950", "1951", "1952", "1953", "1954", "1955", "1956", "1957", "1958", "1959", "1960", "1961", "1962", "1963", "1964", "1965", "1966", "1967", "1968", "1969", "1970", "1971", "1972", "1973", "1974", "1975", "1976", "1977", "1978", "1979", "1980", "1981", "1982", "1983", "1984", "1985", "1986", "1987", "1988", "1989", "1990", "1991", "1992", "1993", "1994", "1995", "1996", "1997", "1998", "1999", "2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025"]
        
        itemPicker.delegate = self
        itemPicker.dataSource = self
        
    }


    @IBAction func stepValChanged(_ sender: UIStepper) {
        numLabel.text = String(Int(sender.value))
        numSlider.value = Float(sender.value)
        progressBar.progress = Float(sender.value)/100
        
    }
    
    @IBAction func sliderChange(_ sender: UISlider) {
        numLabel.text = String(Int(sender.value))
        stepperBtn.value = Double(sender.value)
        progressBar.progress = Float(sender.value)/100
        
    }
    
    
    @IBAction func submitPicker(_ sender: Any) {
        print(itemDay[itemPicker.selectedRow(inComponent: 0)])
    
        print(itemMonth[itemPicker.selectedRow(inComponent: 1)])   
        
        print(itemYear[itemPicker.selectedRow(inComponent: 2)])
        
    }
    
    
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0){
            return itemDay.count
        }else if (component == 1){
            return itemMonth.count
        }else{
            return itemYear.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0){
            return itemDay[row]
        }else if (component == 1){
            return itemMonth[row]
        }else{
            return itemYear[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0){
            print(itemDay[row])
        }else if (component == 1){
            print(itemMonth[row])
        }else{
            print(itemYear[row])
        }
    }
    
    
}
