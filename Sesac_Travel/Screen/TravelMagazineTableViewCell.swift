//
//  TravelMagazineTableViewCell.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/26/24.
//

import UIKit
import Kingfisher

class TravelMagazineTableViewCell: UITableViewCell {

    @IBOutlet private var magazineImageView: UIImageView!
    @IBOutlet private var magazineTitleLabel: UILabel!
    @IBOutlet private var magazineSubtitleLabel: UILabel!
    @IBOutlet private var publishedDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(data: Magazine) {
        self.configureMagazineImageView(imageURL: data.photo_image)
        self.configureMagazineTitleLabel(text: data.title)
        self.configureMagazineSubtitleLabel(text: data.subtitle)
        self.configurePublishedDateLabel(date: data.date)
    }
    
    private func configureMagazineImageView(imageURL url: String) {
        let imageURL = URL(string: url)
        
        self.magazineImageView.kf.setImage(with: imageURL)
        self.magazineImageView.layer.cornerRadius = 10
        self.magazineImageView.contentMode = .scaleAspectFill
    }
    
    private func configureMagazineTitleLabel(text title: String) {
        self.magazineTitleLabel.text = title
        self.magazineTitleLabel.textColor = .black
        self.magazineTitleLabel.font = .boldSystemFont(ofSize: 20)
        self.magazineTitleLabel.numberOfLines = 2
    }
    
    private func configureMagazineSubtitleLabel(text subtitle: String) {
        self.magazineSubtitleLabel.text = subtitle
        self.magazineSubtitleLabel.textColor = .lightGray
        self.magazineSubtitleLabel.font = .systemFont(ofSize: 15, weight: .medium)
    }
    
    private func configurePublishedDateLabel(date: String) {
        let formattedDateString = date.formatDate(inputDateFormat: "yyMMdd", outputDateFormat: "yy년 MM월 dd일")
        
        self.publishedDateLabel.text = formattedDateString
        self.publishedDateLabel.textColor = .lightGray
        self.publishedDateLabel.font = .systemFont(ofSize: 13, weight: .medium)
    }

}
