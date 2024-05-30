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
    private let sb = UIStoryboard(name: "Main", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityDetailTableView.backgroundColor = .white
        self.cityDetailTableView.delegate = self
        self.cityDetailTableView.dataSource = self
        self.cityDetailTableView.register(UINib(nibName: CityDetailTableViewCell.reusableIdentifer, bundle: nil), forCellReuseIdentifier: CityDetailTableViewCell.reusableIdentifer)
        self.cityDetailTableView.register(UINib(nibName: ADTableViewCell.reusableIdentifer, bundle: nil), forCellReuseIdentifier: ADTableViewCell.reusableIdentifer)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let travel = self.travelList[indexPath.row]
        let identifier = (travel.ad) ? ADInfoViewController.identifier : TravelInfoViewController.identifier
        let nextVC = self.sb.instantiateViewController(withIdentifier: identifier)
        if (travel.ad) {
            self.moveToADInfoVC(nextVC: nextVC, data: travel, indexPath: indexPath)
        } else {
            self.moveToTravelInfoVC(nextVC: nextVC, data: travel)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let travel = travelList[indexPath.row]
        
        return (travel.ad) ? 80 : 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let travel = self.travelList[indexPath.row]
        let id = (travel.ad) ? ADTableViewCell.reusableIdentifer : CityDetailTableViewCell.reusableIdentifer

        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        
        guard let travelDetailCell = cell as? TravelDetailCellProtocol else {
            return UITableViewCell()
        }
        
        travelDetailCell.configureCellData(data: travel)
        return cell
    }
}


//MARK: - View Transition Handling
extension CityDetailViewController {
    private func moveToADInfoVC(nextVC: UIViewController, data: Travel, indexPath: IndexPath) {
        let cell = self.cityDetailTableView.cellForRow(at: indexPath)

        guard let adCell = cell as? ADTableViewCell else { return }
        guard let adVC = nextVC as? ADInfoViewController else { return }
        
        adVC.adContent = data.title
        adVC.color = adCell.contentsColor
        let nav = UINavigationController(rootViewController: adVC)
        nav.modalPresentationStyle = .fullScreen
        
        self.present(nav, animated: true)
    }
    
    private func moveToTravelInfoVC(nextVC: UIViewController, data: Travel) {
        guard let travelInfoVC = nextVC as? TravelInfoViewController else { return }
        
        travelInfoVC.city = data
        self.navigationController?.pushViewController(travelInfoVC, animated: true)
    }
}

