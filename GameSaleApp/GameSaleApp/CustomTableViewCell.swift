//
//  CustomTableViewCell.swift

import UIKit
import Kingfisher

class CustomTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var games = [Results]()
    
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Configure the collection view layout for horizontal scrolling
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        return games.count
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        //        cell.textLabel.text = items[indexPath.row]
//        if indexPath.row == 0 {
//        if games[indexPath.row].background_image == nil {
//        
//            var cellUrl = URL(string: "https://placehold.co/400")
//            
//            cell.bannerImage.kf.setImage(with: cellUrl)
//            cell.gameName.text = games[indexPath.row].name
//        } else {
//            var cellUrl = URL(string: games[indexPath.row].background_image ?? "-")
//            
//            cell.bannerImage.kf.setImage(with: cellUrl)
//            cell.gameName.text = games[indexPath.row].name
//        }
           
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 145, height: 313)
    }
}





