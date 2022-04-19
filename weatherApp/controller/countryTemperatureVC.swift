//
//  countryTemperatureVC.swift
//  weatherApp
//
//  Created by SARVADHI on 15/04/22.
//

import UIKit

class countryTemperatureVC: UIViewController {

    
    @IBOutlet weak var lblOutlet: UILabel!
    
    @IBOutlet weak var tempLbl: UILabel!
    
    var countryName = ""
    var  temp = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblOutlet.text = countryName
        tempLbl.text = temp
    }
 
    
}
