//
//  TravelInfoViewController.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/29/24.
//

import UIKit

class TravelInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "관광지 화면"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension TravelInfoViewController: UIViewControllerProtocol {
    static let identifier = String(describing: TravelInfoViewController.self)
}
