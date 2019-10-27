//
//  ViewController.swift
//  gpa
//
//  Created by Jiwoo Lee on 2019-10-26.
//  Copyright © 2019 Jiwoo Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var course1: UITextField!
    @IBOutlet weak var course2: UITextField!
    @IBOutlet weak var course3: UITextField!
    @IBOutlet weak var course4: UITextField!
    @IBOutlet weak var course5: UITextField!
    
    @IBOutlet weak var convertB: UIButton!
    
    @IBOutlet weak var result: UILabel!
    

    
    func exitKeyboard() {
        course1.resignFirstResponder()
        course2.resignFirstResponder()
        course3.resignFirstResponder()
        course4.resignFirstResponder()
        course5.resignFirstResponder()
    }
    
    func resetTextField() {
        course1.text = ""
        course2.text = ""
        course3.text = ""
        course4.text = ""
        course5.text = ""
        result.text = ""
    }
    
    @IBAction func convertButton() {
        exitKeyboard()
        compute()
    }
    
    @IBAction func resetButton() {
        exitKeyboard()
        resetTextField()
        convertB.isEnabled = true
        result.text = "0"
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        course1.delegate = self
        course2.delegate = self
        course3.delegate = self
        course4.delegate = self
        course5.delegate = self

        
        // Do any additional setup after loading the view.
        course1.keyboardType = UIKeyboardType.numberPad
        course2.keyboardType = UIKeyboardType.numberPad
        course3.keyboardType = UIKeyboardType.numberPad
        course4.keyboardType = UIKeyboardType.numberPad
        course5.keyboardType = UIKeyboardType.numberPad
        
//        convertB.isEnabled = false
        course1.delegate = self
        course2.delegate = self
        course3.delegate = self
        course4.delegate = self
        course5.delegate = self
        
        
    }
    
    func compute() {
        
        //Check for valid input
        var inputs: [Double] = []

        let val1String = course1.text
        let val1:Double = NSString(string: val1String!).doubleValue
        inputs.append(val1)
        
        let val2String = course2.text
        let val2:Double = NSString(string: val2String!).doubleValue
        inputs.append (val2)
        
        let val3String = course3.text
        let val3:Double = NSString(string: val3String!).doubleValue
        inputs.append(val3)
        
        let val4String = course4.text
        let val4:Double = NSString(string: val4String!).doubleValue
        inputs.append(val4)
        
        let val5String = course5.text
        let val5:Double = NSString(string: val5String!).doubleValue
        inputs.append(val5)
        
        //validate the range and if key exists
        for n in inputs {
            if !validateRange(input: n) || !keyExists(input: n) {
                result.text = "Invalid input"
                return
            }
        }
        
        convertB.isEnabled = true
        
        //Loop through array, convert to 4 scale
        for i in 0...4 {
            let value = conversion[inputs[i]]
            inputs[i] = value!
        }
        
        //Calculate average
        var sum = 0.0
        for n in inputs {
            sum += n
        }
        let average = sum / 5
        
        let output = Double(round(1000*average)/1000) //3 digit precision
        
        result.text = String(output)
        
    }

    //Convert individual 12 point scale GPAs
    var conversion:[Double:Double] = [12.0 : 4.0,
                                      11.0 : 3.9,
                                      10.0 : 3.7,
                                      9.0 : 3.3,
                                      8.0 : 3.0,
                                      7.0 : 2.7,
                                      6.0 : 2.3,
                                      5.0 : 2.0,
                                      4.0 : 1.7,
                                      3.0 : 1.3,
                                      2.0 : 1.0,
                                      1.0 : 0.7,
                                      0.0 : 0.0 ]
    
    
    
    var input: [Double] = []
    
    func validateRange(input: Double) -> Bool {
        if (0.0 <= input && 12 >= input) {
            return true
        } else {
            return false
        }
    }
    
    func keyExists(input: Double) -> Bool {
        if !conversion.keys.contains(input) {
            return false
        }
        return true
    }




}

