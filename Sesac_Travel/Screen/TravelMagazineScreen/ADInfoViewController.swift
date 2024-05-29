//
//  ADInfoViewController.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/29/24.
//

import UIKit

class ADInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        self.navigationItem.title = "광고 화면"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))
        self.navigationController?.navigationBar.tintColor = .black
    }

    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
}

extension ADInfoViewController: UIViewControllerProtocol {
    static let identifier = String(describing: ADInfoViewController.self)
}
