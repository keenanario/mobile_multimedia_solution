//
//  ViewController.swift
//  Pertemuan 3 Tutorial
//
//  Created by Ario on 10/10/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var inputTemperature: UITextField!
    @IBOutlet var txtTemperature: UILabel!
    @IBOutlet var convertToF: UIButton!
    @IBOutlet var convertToC: UIButton!
    @IBOutlet var shareBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toFahrenheit(_ sender: Any) {
        let temp = inputTemperature.text!
        let celcius = Float(temp)!
        let fahrenheit = celcius * 9 / 5 + 32
        txtTemperature.text = "\(fahrenheit) F"
    }
    
    @IBAction func toCelcius(_ sender: Any) {
        let temp = inputTemperature.text!
        let fahrenheit = Float(temp)!
        let celcius = (fahrenheit - 32) * 5 / 9
        txtTemperature.text = "\(celcius) C"
    }
    
    @IBAction func textFieldDoneEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    @IBAction func share(_ sender: Any) {
        let defaultAction = UIAlertAction(title: "Agree", style: .default){
            (action) in
            //respond klik agree
        }
        
        let cancelAction = UIAlertAction(title: "Disagree", style: .cancel) {
            (action) in
            //respond klik disagree
        }
        
        let alert = UIAlertController(title: "Terms and Condition", message: "Click agree to accept the terms and conditions.", preferredStyle: .alert)
        
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true){
            
        }
    }
}

