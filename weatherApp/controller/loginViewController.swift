//
//  loginViewController.swift
//  Weather App
//
//  Created by SARVADHI on 11/04/22.
//

import UIKit

class loginViewController: UIViewController {
    
    @IBOutlet weak var userIdTxtOutlet: UITextField!
    @IBOutlet weak var passwordTxtOutlet: UITextField!
    
    
    var email = "test@test.com"
    var password = "1234"
    
    @IBOutlet weak var loginBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: constants.isUserLogin) == true {
            self.performSegue(withIdentifier: constants.mainTabbarIdetinfier, sender: self)
            
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        
        if email == userIdTxtOutlet.text && password == passwordTxtOutlet.text {

            UserDefaults.standard.set(true, forKey: constants.isUserLogin)
//        Switcher.updateRootVC()
            performSegue(withIdentifier: constants.mainTabbarIdetinfier, sender: self)
        }else {
            let alert = UIAlertController(title: "Alert!", message: "email or password is incorreect", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        
       
       
        
    }
    
    
  
}
