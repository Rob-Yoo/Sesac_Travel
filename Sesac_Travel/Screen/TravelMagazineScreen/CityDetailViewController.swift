//
//  CityDetailViewController.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/27/24.
//

import UIKit

class CityDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var cityDetailTableView: UITableView!
    
    private let travelList = TravelInfo().travel

    override func viewDidLoad() {
        let cityDetailTableViewCell = String(describing: CityDetailTableViewCell.self)
        let adTableViewCell = String(describing: ADTableViewCell.self)

        super.viewDidLoad()
        self.cityDetailTableView.backgroundColor = .white
        self.cityDetailTableView.delegate = self
        self.cityDetailTableView.dataSource = self
        self.cityDetailTableView.register(UINib(nibName: cityDetailTableViewCell, bundle: nil), forCellReuseIdentifier: cityDetailTableViewCell)
        self.cityDetailTableView.register(.init(nibName: adTableViewCell, bundle: nil), forCellReuseIdentifier: adTableViewCell)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.travelList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let travel = self.travelList[indexPath.row]
        
        return (travel.ad) ? 75 : 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        let travel = self.travelList[indexPath.row]
        let id = (travel.ad) ? ADTableViewCell.reusableIdentifer : CityDetailTableViewCell.reusableIdentifer

        let cell = self.cityDetailTableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        
        guard let travelDetailCell = cell as? TravelDetailCellProtocol else {
            return UITableViewCell()
        }
        
        travelDetailCell.configureCellData(data: travel)
        return cell
    }
}

