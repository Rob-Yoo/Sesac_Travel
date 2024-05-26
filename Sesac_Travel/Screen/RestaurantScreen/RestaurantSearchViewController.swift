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
    @IBOutlet private var foodTypeButtons: [UIButton]!

    @IBOutlet var restaurantTableView: UITableView!
    
    private var viewModel = RestaurantViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSearchBackgroundView()
        self.configureSearchTextField()
        self.configureSearchButton()
        self.configureFoodTypeButtons()

        self.restaurantTableView.delegate = self
        self.restaurantTableView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateRestaurantList), name: .RestaurantModelChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .RestaurantModelChanged, object: nil)
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let query = self.searchTextField.text else { return }
        
        self.viewModel.fetchSearchedRestaurants(query: query)
        self.view.endEditing(true)
    }
    
    @IBAction func foodTypeButtonsTapped(sender: UIButton) {
        let text = sender.titleLabel?.text ?? ""
        
        self.searchTextField.text = text
        self.viewModel.fetchSearchedRestaurants(query: text)
    }
}

//MARK: - UITableView Setting
extension RestaurantSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.output.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableIdentifier = String(describing: RestaurantTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as! RestaurantTableViewCell
        let data = self.viewModel.output[indexPath.row]
        
        cell.configure(data: data, tag: indexPath.row)
        cell.starButton.addTarget(self, action: #selector(self.starButtonTapped), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 325
    }
}

//MARK: - Configure Subviews
extension RestaurantSearchViewController {
    private func configureSearchBackgroundView() {
        self.searchBackgroundView.layer.cornerRadius = 15
    }
    
    private func configureSearchTextField() {
        self.searchTextField.placeholder = "가게명, 주소를 검색해보세요."
        self.searchTextField.borderStyle = .none
        self.searchTextField.textColor = .black
    }
    
    private func configureSearchButton() {
        self.searchButton.layer.cornerRadius = 10
    }
    
    private func configureFoodTypeButtons() {
        let titles = ["한식", "일식", "중식", "양식", "카페"]

        for (btn, title) in zip(self.foodTypeButtons, titles) {
            self.configureFoodTypeButton(btn: btn, title: title)
        }
    }
    
    private func configureFoodTypeButton(btn: UIButton, title: String) {
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.setTitle(title, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
    }
}

//MARK: - User Action Handling
extension RestaurantSearchViewController {
    @objc private func starButtonTapped(sender: UIButton) {
        let idx = sender.tag
        let indexPath = IndexPath(row: idx, section: 0)
        let id = self.viewModel.output[idx].id
        
        self.viewModel.updateIsStar(idx: idx, id: id)
        self.restaurantTableView.reloadRows(at: [indexPath], with: .none)
    }
    
    @objc private func updateRestaurantList() {
        self.restaurantTableView.reloadData()
    }
}

