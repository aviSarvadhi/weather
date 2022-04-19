//
//  searchWeatherVC.swift
//  Weather App
//
//  Created by SARVADHI on 11/04/22.
//

import UIKit

class searchWeatherVC: UIViewController {
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
   

  
   

    
    @IBOutlet weak var imgTempOutlet: UIImageView!
    @IBOutlet weak var backImgOutlet: UIImageView!
    
    @IBOutlet weak var celsiusLblOutlet: UILabel!
    
    @IBOutlet weak var tempNoLabel: UILabel!
    @IBOutlet weak var cityNameLabelOutlet: UILabel!
    
    
    
    var cityName =  ""
    var temp:Float = 0.0
    var imageID = 0
    var imgIdStr = ""
    var weatherModelVm = weatherViewModel()
    var weatherModels : weatherModel?
    var weatherid = [weatherID]()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherModelVm.vc = self
        self.searchBarOutlet.delegate = self
        
       
     //   hideAllValue()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideAllValue()
        
    }
    @IBAction func logoutBtnAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: constants.isUserLogin)
        self.navigationController?.popToRootViewController(animated: true)
       // bool(forKey: "IsUserLogin")
    }
    
    
    func hideAllValue() {
        imgTempOutlet.isHidden = true
        celsiusLblOutlet.isHidden = true
        cityNameLabelOutlet.isHidden = true
        tempNoLabel.isHidden = true
    }
    func unhideAllValue() {
        imgTempOutlet.isHidden = false
        celsiusLblOutlet.isHidden = false
        cityNameLabelOutlet.isHidden = false
        tempNoLabel.isHidden = false
    }
    
    func weatherImg() {
        
        switch imageID {
            
        case 200...232 :
            imgTempOutlet.isHidden = false
            imgTempOutlet.image =  UIImage(systemName: "cloud.bolt")
//            backImgOutlet.image = UIImage(named: "thunderStromImg")
//            backImgOutlet.alpha = 0.65
        case 300...321 :
            
            imgTempOutlet.isHidden = false
            imgTempOutlet.image =  UIImage(systemName: "cloud.sun.rain")
//            backImgOutlet.image = UIImage(named: "RainyImg")
//            backImgOutlet.alpha = 0.65
            
            
        case 500...531 :
            
            imgTempOutlet.isHidden = false
            imgTempOutlet.image =  UIImage(systemName: "cloud.sun.rain.fill")
//            backImgOutlet.image = UIImage(named: "RainyImg")
//            backImgOutlet.alpha = 0.65
//
        case 600...622 :
            
            imgTempOutlet.isHidden = false
            imgTempOutlet.image =  UIImage(systemName: "snowflake")
            imgTempOutlet.tintColor = .blue
//            backImgOutlet.image = UIImage(named: "winterImg")
//            backImgOutlet.alpha = 0.65

        case 800 :
            
            imgTempOutlet.isHidden = false
            imgTempOutlet.image =  UIImage(systemName: "cloud")
         //   backImgOutlet.image = UIImage(named: "sunRise")
//            backImgOutlet.alpha = 0.65
        case 801...804 :
            
            imgTempOutlet.isHidden = false
            imgTempOutlet.image =  UIImage(systemName: "cloud.sun")
            imgTempOutlet.tintColor = .yellow
//            backImgOutlet.image = UIImage(named: "sunRise")
//            backImgOutlet.alpha = 0.65
            
        default:
            print("error")
        }
    }
    
    func backgorundImgChange() {
//        switch temp {
//        case -100.0...10.00:
//            backImgOutlet.image = UIImage(named: "")
//
//
//
//
//        default:
//            <#code#>
//        }
    }
    
    
  
}

extension searchWeatherVC : UISearchBarDelegate,UISearchDisplayDelegate {
    
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         
            self.hideAllValue()
            
                
          
        }
       
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
           
            cityName = searchBarOutlet.text!

            let Name = cityName.components(separatedBy: .whitespacesAndNewlines)
            
            weatherModelVm.weatherCityApicall(cityName: Name.joined(separator: ""), onSuccess:{ succesValue in

                DispatchQueue.main.async {
                    self.unhideAllValue()
                    self.temp = Float(((self.weatherModels?.main.temp)!) - 273.15)
                    self.cityNameLabelOutlet.text = self.weatherModels?.name
                    let IdImage:[Int] = (self.weatherModels?.weather.map({($0.imageId)}))!
//                    let myArray = [1,5,2]
//                    var myString = ""
//                    _ = myArray.map{ myString = myString + "\($0)" }
//                    let myInt = Int(myString)
                   _ = (self.weatherModels?.weather.map({(self.imgIdStr = "\($0.imageId)")}))
                    self.imageID = Int(self.imgIdStr)!
                    self.tempNoLabel.text = "\(self.temp)"
                 //   self.imageID = self.weatherid.imageId
                    self.weatherImg()
                    
                }
              
               
            }, onError: {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "", message: "No Data Found", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
              
            })
            
            
        }
        
      
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
    //        tableViewRXOutlet.isHidden = false
            
            
        }
    
    
}

