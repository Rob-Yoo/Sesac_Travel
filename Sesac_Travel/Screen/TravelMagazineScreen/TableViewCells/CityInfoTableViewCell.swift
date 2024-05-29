//
//  CityInfoTableViewCell.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/29/24.
//

import UIKit
import Kingfisher

class CityInfoTableViewCell: UITableViewCell {

    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var blackOpacityView: UIView!
    @IBOutlet var cityExplainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureLayout()
    }

    func configureCellData(data: City) {
        let url = URL(string: data.city_image)

        self.cityNameLabel.text = data.city_name + " | " + data.city_english_name
        self.cityImageView.kf.setImage(with: url)
        self.cityExplainLabel.text = data.city_explain
    }
    
    private func configureLayout() {
        self.configureCityImageView()
        self.configureCityNameLabel()
        self.configureBlackOpacityView()
        self.configureCityExplainLabel()
    }
    
    private func configureCityImageView() {
        self.cityImageView.contentMode = .scaleAspectFill
    }
    
    private func configureCityNameLabel() {
        self.cityNameLabel.textColor = .white
        self.cityNameLabel.font = .boldSystemFont(ofSize: 15)
    }
    
    private func configureBlackOpacityView() {
        self.blackOpacityView.backgroundColor = UIColor(white: 0, alpha: 0.8)
    }
    
    private func configureCityExplainLabel() {
        self.cityExplainLabel.textColor = .white
        self.cityExplainLabel.font = .systemFont(ofSize: 8, weight: .light)
    }
}

extension CityInfoTableViewCell: UITableViewCellProtocol {
    static let reusableIdentifer = String(describing: CityInfoTableViewCell.self)
}
