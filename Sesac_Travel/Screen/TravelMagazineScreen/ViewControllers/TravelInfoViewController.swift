//
//  TravelInfoViewController.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/29/24.
//

import UIKit

class TravelInfoViewController: UIViewController {

    @IBOutlet private var imageContainerView: UIView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var heartButton: UIButton!
    @IBOutlet private var cityTitleLabel: UILabel!
    @IBOutlet private var cityDescriptionLabel: UILabel!
    @IBOutlet private var cityDetailLabel: UILabel!
    
    var city: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavigationBar()
        self.configureImageContainerView()
        self.configureHeartButton()
        self.configureCityTitleLabel()
        self.configureCityDescriptionLabel()
        self.configureCityDetailLabel()
    }
}

//MARK: - Configure Subviews
extension TravelInfoViewController {
    private func configureNavigationBar() {
        self.navigationItem.title = "관광지 화면"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func configureImageContainerView() {
        guard let imgURL = self.city?.travel_image else { return }
        
        let url = URL(string: imgURL)


        self.imageView.layer.cornerRadius = 15
        self.imageView.kf.setImage(with: url)
        self.imageView.contentMode = .scaleAspectFill
    }
    
    private func configureHeartButton() {
        guard let isHeart = self.city?.like else { return }
        
        let systemName = (isHeart) ? "heart.fill" : "heart"
        let imgConfiguration = UIImage.SymbolConfiguration(
            font: .boldSystemFont(ofSize: 20))
        let image = UIImage(systemName: systemName, withConfiguration: imgConfiguration)
        
        self.heartButton.setImage(image, for: .normal)
        self.heartButton.setTitle("", for: .normal)
        self.heartButton.tintColor = .white
    }
    
    private func configureCityTitleLabel() {
        let title = city?.title

        self.cityTitleLabel.text = title
        self.cityTitleLabel.textColor = .black
        self.cityTitleLabel.font = .systemFont(ofSize: 20, weight: .medium)
    }
    
    private func configureCityDescriptionLabel() {
        let description = self.city?.description

        self.cityDescriptionLabel.text = description
        self.cityDescriptionLabel.font = .systemFont(ofSize: 15, weight: .regular)
        self.cityDescriptionLabel.numberOfLines = 0
        self.cityDescriptionLabel.textColor = .lightGray
    }
    
    private func configureCityDetailLabel() {
        guard let grade = city?.grade, let saveCount = city?.save else {
            return
        }

        self.cityDetailLabel.text = "평점 \(grade) | 저장 " + saveCount.formatted()
        self.cityDetailLabel.font = .systemFont(ofSize: 15, weight: .regular)
        self.cityDetailLabel.textColor = .lightGray
    }
}

//MARK: - User Action Handling
extension TravelInfoViewController {
    @objc private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension TravelInfoViewController: UIViewControllerProtocol {
    static let identifier = String(describing: TravelInfoViewController.self)
}
