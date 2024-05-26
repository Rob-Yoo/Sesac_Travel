//
//  RestaurantTableViewCell.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/26/24.
//

import UIKit
import Kingfisher

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var starButton: UIButton!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(data: Restaurant) {
        self.configureRestaurantImageView(imageURL: data.image)
        self.configureNameLabel(name: data.name)
        self.configureAddressLabel(address: data.address)
        self.configurePhoneNumberLabel(phoneNumber: data.phoneNumber)
    }
    
    private func configureRestaurantImageView(imageURL url: String) {
        let imageURL = URL(string: url)
        
        self.restaurantImageView.kf.setImage(with: imageURL)
        self.restaurantImageView.contentMode = .scaleAspectFill
        self.restaurantImageView.layer.cornerRadius = 10
    }
    
    private func configureNameLabel(name text: String) {
        self.nameLabel.text = text
        self.nameLabel.textColor = .black
        self.nameLabel.font = .boldSystemFont(ofSize: 20)
    }
    
    private func configureAddressLabel(address text: String) {
        self.addressLabel.text = text
        self.addressLabel.textColor = .lightGray
        self.addressLabel.font = .systemFont(ofSize: 15, weight: .medium)
    }
    
    private func configurePhoneNumberLabel(phoneNumber text: String) {
        self.phoneNumberLabel.text = text
        self.phoneNumberLabel.textColor = .lightGray
        self.phoneNumberLabel.font = .systemFont(ofSize: 15, weight: .medium)
    }
}
