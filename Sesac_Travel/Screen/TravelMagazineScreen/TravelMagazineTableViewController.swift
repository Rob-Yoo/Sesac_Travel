//
//  TravelMagazineTableViewController.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/26/24.
//

import UIKit

class TravelMagazineTableViewController: UITableViewController {
    
    private var model = MagazineInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 450
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .white
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.magazine.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableIdentifier = String(describing: TravelMagazineTableViewCell.self)
        let cell = self.tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as! TravelMagazineTableViewCell
        let data = self.model.magazine[indexPath.row]
        
        cell.configure(data: data)
        return cell
    }
}
