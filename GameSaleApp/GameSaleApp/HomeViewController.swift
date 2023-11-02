//
//  HomeViewController.swift


import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var games = [Results]()
    
    var sections = ["Loot of the day","Free to Play","On-Sale","Upcoming Games"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationItem.title = "Home"
        // Do any additional setup after loading the view.
        //        searchBar.searchTextField.textColor = .white
        //
        //        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        //
        //        textFieldInsideSearchBar?.textColor = UIColor.white
        
        //        var searchController: UISearchController?
        searchBar.compatibleSearchTextField.textColor = UIColor.white
        searchBar.compatibleSearchTextField.backgroundColor = UIColor.white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150 // Set the desired row height
        
        // Register the custom cell
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        
//        fetchData()
    }
    
    func fetchData() {
        guard let url = URL(string: "https://api.rawg.io/api/games?key=4946673f593c458caa1ab1bfffb347d9") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let items = try decoder.decode(GamesModel.self, from: data)
                    print("Items \(items)")
                    self.games = items.results!
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    // Handle the parsed items
//                    for item in items {
//                        print("ID: \(item.id), Name: \(item.name)")
//                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }

    
    
}

extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count // You can have multiple sections with different data if needed
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.sectionTitle.text = sections[indexPath.row]
//        if indexPath.row == 0 {
//            cell.actionButton.tag = indexPath.row
//            cell.actionButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//        } else {
////            cell.sectionTitle.text = sections[indexPath.row]
//            cell.actionButton.tag = indexPath.row
//            cell.actionButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//        }
        cell.sectionTitle.text = sections[indexPath.row]
         cell.actionButton.tag = indexPath.row
        cell.actionButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        cell.games = self.games
        DispatchQueue.main.async {
            cell.collectionView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
//        let indexPath = IndexPath(row: sender.tag, section: 0)
//        let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
//        let title = cell.titleLabel.text
        self.performSegue(withIdentifier: "exploreSegue", sender: nil)
        
        // Handle the button action here
//        print("Button tapped in cell: \(title ?? "Unknown")")
    }
}


extension UISearchBar {
    
    // Due to searchTextField property who available iOS 13 only, extend this property for iOS 13 previous version compatibility
    var compatibleSearchTextField: UITextField {
        guard #available(iOS 13.0, *) else { return legacySearchField }
        return self.searchTextField
    }
    
    private var legacySearchField: UITextField {
        if let textField = self.subviews.first?.subviews.last as? UITextField {
            // Xcode 11 previous environment
            return textField
        } else if let textField = self.value(forKey: "searchField") as? UITextField {
            // Xcode 11 run in iOS 13 previous devices
            return textField
        } else {
            // exception condition or error handler in here
            return UITextField()
        }
    }
}

