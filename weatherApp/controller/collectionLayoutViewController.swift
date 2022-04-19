//
//  collectionLayoutViewController.swift
//  weatherApp
//
//  Created by SARVADHI on 15/04/22.
//
import Foundation
import UIKit

class collectionLayoutViewController: UIViewController {

    
  
    
    
    @IBOutlet weak var tableviewOutlet: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableviewOutlet.delegate = self
        tableviewOutlet.dataSource = self
        tableviewOutlet.estimatedRowHeight = 120
        // Do any additional setup after loading the view.
    }
   
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
   
    

}

extension collectionLayoutViewController : UITableViewDelegate , UITableViewDataSource  {
    func numberOfSections(in tableView: UITableView) -> Int {
    return 5
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Section Title \(section)"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "collectionTableViewCell", for: indexPath) as? collectionTableViewCell
        {
        return cell
        }
        return UITableViewCell()
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    }


    
    
    
    
    

