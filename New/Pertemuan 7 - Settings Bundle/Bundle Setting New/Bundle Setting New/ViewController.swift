//
//  ViewController.swift
//  Bundle Setting New
//
//  Created by Ario on 05/04/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerSettingsBundle()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.defaultChanged), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    //untuk mengambil setting bundle
    func registerSettingsBundle(){
        let appDefaults = [String: AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    
    @objc func defaultChanged(){
        if UserDefaults.standard.bool(forKey: "change_background"){
            self.view.backgroundColor = UIColor.cyan
        }else{
            self.view.backgroundColor = UIColor.white
        }
    }


}

