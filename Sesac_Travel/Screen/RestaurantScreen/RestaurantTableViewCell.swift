//
//  RestaurantTableViewCell.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/26/24.
//

import UIKit
import Kingfisher

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet var restaurantImageContainerView: UIView!
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var starButton: UIButton!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .white
        self.configureLayout()
        self.starButton.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
    }

    func configure(data: Restaurant, tag: Int) {
        let starImageName = data.isStar ? "star.fill" : "star"
        let starImage = UIImage(systemName: starImageName)
        let imageURL = URL(string: data.image)
        
        self.restaurantImageView.kf.setImage(with: imageURL)
        self.starButton.setImage(starImage, for: .normal)
        self.starButton.tag = tag
        self.nameLabel.text = data.name
        self.addressLabel.text = data.address
        self.phoneNumberLabel.text = data.phoneNumber
    }
    
    @objc private func starButtonTapped(sender: UIButton) {
        
    }
    
    private func configureLayout() {
        self.configureRestaurantImageView()
        self.configureNameLabel()
        self.configureAddressLabel()
        self.configurePhoneNumberLabel()
    }
    
    private func configureRestaurantImageView() {
        self.restaurantImageContainerView.backgroundColor = .clear
        self.restaurantImageView.contentMode = .scaleAspectFill
        self.restaurantImageView.layer.cornerRadius = 10
    }
    
    private func configureNameLabel() {
        self.nameLabel.textColor = .black
        self.nameLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    private func configureAddressLabel() {
        self.addressLabel.textColor = .lightGray
        self.addressLabel.font = .systemFont(ofSize: 15, weight: .medium)
    }
    
    private func configurePhoneNumberLabel() {
        self.phoneNumberLabel.textColor = .lightGray
        self.phoneNumberLabel.font = .systemFont(ofSize: 15, weight: .medium)
    }
}

extension RestaurantTableViewCell: UITableViewCellProtocol {
    static let reusableIdentifer = String(describing: RestaurantTableViewCell.self)
}
