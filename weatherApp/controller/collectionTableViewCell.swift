//
//  collectionTableViewCell.swift
//  weatherApp
//
//  Created by SARVADHI on 16/04/22.
//

import UIKit

class collectionTableViewCell: UITableViewCell {
    
    
    var imageName:[String] = ["background","cloudyweather","background","cloudyweather","background"]
    var nameValue:[String] = ["1","2","3","4","5","6","1","2","3","4","5","6"]
    var AllValue = [String]()
    
    @IBOutlet weak var collectionViewOutlet: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewOutlet.delegate = self
        collectionViewOutlet.dataSource = self
        
        collectionViewOutlet.register(UINib(nibName: constants.rectangleCellIdentifier, bundle: nil), forCellWithReuseIdentifier: constants.rectangleCellIdentifier)
        collectionViewOutlet.register(UINib(nibName: constants.squareCellIdentifier, bundle: nil), forCellWithReuseIdentifier: constants.squareCellIdentifier)
        
        AllValue = imageName + nameValue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension collectionTableViewCell : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AllValue.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: constants.rectangleCellIdentifier, for: indexPath) as? rectangleCVcell
        let randomNumber = Int(arc4random_uniform(UInt32(imageName.count)))

        switch indexPath.row {
        case 0,2,4,6 :
           
            cell?.rectangleImgOutlet.image = UIImage(named: imageName[2])
            return cell!
        default:
            break
            
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    let size = CGSize(width: 120, height: 120)
    return size
    }

    
    
    
}
