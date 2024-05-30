//
//  ADInfoViewController.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/29/24.
//

import UIKit

class ADInfoViewController: UIViewController {

    @IBOutlet private var adLabel: UILabel!
    
    var color: UIColor = .white
    var adContent: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = color
        self.configureNavigationBar()
        self.configureADContentLabel()
    }
}

//MARK: - Configure Subviews
extension ADInfoViewController {
    private func configureNavigationBar() {
        self.navigationItem.title = "광고 화면"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func configureADContentLabel() {
        self.adLabel.text = adContent
        self.adLabel.textColor = .black
        self.adLabel.textAlignment = .center
        self.adLabel.font = .boldSystemFont(ofSize: 20)
        self.adLabel.numberOfLines = 0
    }
}

//MARK: - User Action Handling
extension ADInfoViewController {
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
}

extension ADInfoViewController: UIViewControllerProtocol {
    static let identifier = String(describing: ADInfoViewController.self)
}
