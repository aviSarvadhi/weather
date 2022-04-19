//
//  DetailWeatherVC.swift
//  Weather App
//
//  Created by SARVADHI on 11/04/22.
//

import UIKit

class DetailWeatherVC: UIViewController {
    
    @IBOutlet weak var tableViewOutlet:UITableView!
    
    @IBOutlet weak var searchBarOutlet:UISearchBar!
    
   var countryList = [String]()
    var countriesData = [(name: String, flag: String)]()
    var searchlist = [String]()
    var searching = false
    var weatherVM = weatherViewModel()
    var weatherModels : weatherModel?
    
    
    var temp:Float = 0.0
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.weatherVM.DetailVc = self
        self.navigationController?.navigationBar.isHidden = false
        
        searchBarOutlet.delegate = self
        self.searchBarOutlet.showsCancelButton = true
       
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        listOfCountries()
    }
    
    func listOfCountries() {
            for code in NSLocale.isoCountryCodes as [String] {
                let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
                let name = NSLocale(localeIdentifier: "en").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
                countryList.append(name + " " + countryFlag(country: code))
                tableViewOutlet.reloadData()
            }
        }
        
        // Add Flag Emoji
        func countryFlag(country: String) -> String {
            let base: UInt32 = 127397
            var s = ""
            for v in country.unicodeScalars {
                s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
            }
            return String(s)
        }
    
    @IBAction func logouBtnAction(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: constants.isUserLogin)
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
}






extension String {

    static func emojiFlag(for countryCode: String) -> String! {
        func isLowercaseASCIIScalar(_ scalar: Unicode.Scalar) -> Bool {
            return scalar.value >= 0x61 && scalar.value <= 0x7A
        }

        func regionalIndicatorSymbol(for scalar: Unicode.Scalar) -> Unicode.Scalar {
            precondition(isLowercaseASCIIScalar(scalar))

            // 0x1F1E6 marks the start of the Regional Indicator Symbol range and corresponds to 'A'
            // 0x61 marks the start of the lowercase ASCII alphabet: 'a'
            return Unicode.Scalar(scalar.value + (0x1F1E6 - 0x61))!
        }

        let lowercasedCode = countryCode.lowercased()
        guard lowercasedCode.count == 2 else { return nil }
        guard lowercasedCode.unicodeScalars.reduce(true, { accum, scalar in accum && isLowercaseASCIIScalar(scalar) }) else { return nil }

        let indicatorSymbols = lowercasedCode.unicodeScalars.map({ regionalIndicatorSymbol(for: $0) })
        return String(indicatorSymbols.map({ Character($0) }))
    }
}



extension DetailWeatherVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
                   return searchlist.count
               } else {
                   return countryList.count
               }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if searching {
                  cell.textLabel?.text = searchlist[indexPath.row]
              } else {
                  cell.textLabel?.text = countryList[indexPath.row]
              }
        
        return cell
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: constants.countryTempIdentifier) as? countryTemperatureVC
        var  selectedCountry:String?
            if searching {
                selectedCountry   = searchlist[indexPath.row]
                print(selectedCountry)

            } else {
            selectedCountry = countryList[indexPath.row]
                print(selectedCountry)
            }
        
       
        
        selectedCountry?.removeLast()
        
       
        
        let test = String(selectedCountry!.filter { !" ".contains($0) })
        vc?.countryName = selectedCountry!
        weatherVM.weatherCityApicall(cityName: test) { [self] _ in
            DispatchQueue.main.async {
                self.temp = Float(((self.weatherModels?.main.temp) ?? 100) - 273.15)
                vc?.temp = String(describing: temp)
                self.navigationController?.showDetailViewController(vc!, sender: self)
            }
            
        } onError: {
            print("error")
        }

            // Close keyboard when you select cell
      
            self.searchBarOutlet.searchTextField.endEditing(true)
        }
   
}


extension DetailWeatherVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchlist = countryList.filter {$0.lowercased().prefix(searchText.count) == searchText.lowercased()}
           searching =  true
        tableViewOutlet.reloadData()
       }
       
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           searching = false
           
            searchBar.text = ""
            tableViewOutlet.reloadData()

       }
}
       

