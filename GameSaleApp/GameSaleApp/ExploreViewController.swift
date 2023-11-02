//
//  ExploreViewController.swift

import UIKit

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Status bar white font
//        self.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationItem.title = "Explore"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        searchBar.compatibleSearchTextField.textColor = UIColor.white
        searchBar.compatibleSearchTextField.backgroundColor = UIColor.white
        
        tableView.delegate = self
        tableView.dataSource = self
        //        tableView.rowHeight = 150 // Set the desired row height
        
        // Register the custom cell
        tableView.register(UINib(nibName: "ExploreCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "ExploreCustomTableViewCell")
    }
    
}

extension ExploreViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreCustomTableViewCell", for: indexPath) as! ExploreCustomTableViewCell
        //
        //           let (title, imageName) = items[indexPath.row]
        //           cell.titleLabel.text = title
        //           cell.cellImageView.image = UIImage(named: imageName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
