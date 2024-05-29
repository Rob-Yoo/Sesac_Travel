//
//  CityInfoViewController.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/29/24.
//

import UIKit

class CityInfoViewController: UIViewController {

    @IBOutlet var citySearchBar: UISearchBar!
    @IBOutlet var filterSegmentedControl: UISegmentedControl!
    @IBOutlet var cityInfoTableView: UITableView!
    
    private let rawCityList = CityInfo().city
    lazy private var outputCityList = self.rawCityList
    
    override func viewDidLoad() {
        let id = CityInfoTableViewCell.reusableIdentifer
        
        super.viewDidLoad()
        
        self.citySearchBar.delegate = self
        self.cityInfoTableView.dataSource = self
        self.cityInfoTableView.delegate = self
        self.cityInfoTableView.register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let value = sender.selectedSegmentIndex

        self.filterSearchResult(segIdx: value, cityList: self.rawCityList)
        self.cityInfoTableView.reloadData()
    }
}

//MARK: - UITableView 관련 설정
extension CityInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        135ㅇ
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.outputCityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.outputCityList[indexPath.row]
        let id = CityInfoTableViewCell.reusableIdentifer
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as? CityInfoTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCellData(data: data)
        return cell
    }
    

}

extension CityInfoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let segIdx = self.filterSegmentedControl.selectedSegmentIndex
        let nonFilteredCityList = self.rawCityList.filter {
            $0.city_name.contains(searchText) ||
            $0.city_english_name.contains(searchText) ||
            $0.city_english_name.caseInsensitiveCompare(searchText) == .orderedSame ||
            $0.city_explain.contains(searchText)
        }
        
        self.filterSearchResult(segIdx: segIdx, cityList: nonFilteredCityList)
        self.cityInfoTableView.reloadData()
    }
}


//MARK: - Filtering Utility Method
extension CityInfoViewController {
    private func filterSearchResult(segIdx: Int, cityList: [City]) {
        switch segIdx {
        case 0:
            self.outputCityList = cityList
        case 1:
            self.outputCityList = cityList.filter { $0.domestic_travel == true }
        case 2:
            self.outputCityList = cityList.filter { $0.domestic_travel == false }
        default:
            return
        }
    }
}
