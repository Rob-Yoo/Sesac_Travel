//
//  CityDetailTableViewCell.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/27/24.
//

import UIKit

class CityDetailTableViewCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet var detailInfoLabel: UILabel!
    @IBOutlet private var placeImageView: UIImageView!
    @IBOutlet private var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureLayout() {
        self.configureTitleLabel()
        self.configureDescriptionLabel()
        self.configureDetailInfoLabel()
        self.configurePlaceImageView()
    }
    
    private func configureTitleLabel() {
        self.titleLabel.textColor = .black
        self.titleLabel.font = .boldSystemFont(ofSize: 17)
    }
    
    private func configureDescriptionLabel() {
        self.descriptionLabel.textColor = .lightGray
        self.descriptionLabel.font = .systemFont(ofSize: 13, weight: .bold)
        self.descriptionLabel.numberOfLines = 0
    }
    
    private func configureDetailInfoLabel() {
        self.detailInfoLabel.textColor = .lightGray
        self.detailInfoLabel.font = .systemFont(ofSize: 10)
    }
    
    private func configurePlaceImageView() {
        self.placeImageView.layer.cornerRadius = 10
        self.placeImageView.contentMode = .scaleAspectFill
    }
}

extension CityDetailTableViewCell: TravelDetailCellProtocol, UITableViewCellProtocol {
    static var reusableIdentifer = String(describing: CityDetailTableViewCell.self)
    
    func configureCellData(data: Travel) {
        let url = URL(string: data.travel_image!)

        self.titleLabel.text = data.title
        self.descriptionLabel.text = data.description
        self.detailInfoLabel.text = "평점 \(data.grade!) ・ 저장 " + data.save!.formatted()
        self.placeImageView.kf.setImage(with: url)
    }
}
