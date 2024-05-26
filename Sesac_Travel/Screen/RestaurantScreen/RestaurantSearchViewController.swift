//
//  ViewController.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/26/24.
//

import UIKit

class RestaurantSearchViewController: UIViewController {
    @IBOutlet private var searchBackgroundView: UIView!
    @IBOutlet private var searchTextField: UITextField!
    @IBOutlet private var searchButton: UIButton!

    @IBOutlet var restaurantTableView: UITableView!
    
    private var model = RestaurantList()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchBackgroundView()
        self.configureSearchTextField()
        self.configureSearchButton()
        self.restaurantTableView.delegate = self
        self.restaurantTableView.dataSource = self
    }
    
    private func configureSearchBackgroundView() {
        self.searchBackgroundView.layer.cornerRadius = 15
    }
    
    private func configureSearchTextField() {
        self.searchTextField.placeholder = "찾고 싶은 식당이 있으신가요?"
        self.searchTextField.borderStyle = .none
        self.searchTextField.textColor = .black
    }
    
    private func configureSearchButton() {
        self.searchButton.layer.cornerRadius = 10
    }
}

extension RestaurantSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.restaurantArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableIdentifier = String(describing: RestaurantTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as! RestaurantTableViewCell
        let data = self.model.restaurantArray[indexPath.row]
        
        cell.configure(data: data, tag: indexPath.row)
        cell.starButton.addTarget(self, action: #selector(self.starButtonTapped), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325
    }
}

extension RestaurantSearchViewController {
    @objc private func starButtonTapped(sender: UIButton) {
        let idx = sender.tag
        
        self.model.restaurantArray[idx].isStar.toggle()
        self.restaurantTableView.reloadData()
    }
}

