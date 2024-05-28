//
//  ADTableViewCell.swift
//  Sesac_Travel
//
//  Created by Jinyoung Yoo on 5/27/24.
//

import UIKit

class ADTableViewCell: UITableViewCell {

    @IBOutlet var adBackgroundView: UIView!
    @IBOutlet var badgeView: UIView!
    @IBOutlet var adLabel: UILabel!
    
    private var colorList: [UIColor] = [.red, .blue, .orange, .yellow, .green, .purple]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configureLayout()
    }
    
    private func configureLayout() {
        self.contentView.backgroundColor = .white

        self.configureADBackgroundView()
        self.configureBadgeView()
        self.configureADLabel()
    }
    
    private func configureADBackgroundView() {
        let color = self.colorList.randomElement()!

        self.adBackgroundView.backgroundColor = color
        self.adBackgroundView.layer.cornerRadius = 10
    }
    
    private func configureBadgeView() {
        self.badgeView.layer.cornerRadius = 10
        self.badgeView.backgroundColor = .white
    }
    
    private func configureADLabel() {
        self.adLabel.textColor = .black
        self.adLabel.textAlignment = .center
        self.adLabel.font = .boldSystemFont(ofSize: 15)
        self.adLabel.numberOfLines = 0
    }
}

extension ADTableViewCell: TravelDetailCellProtocol, UITableViewCellProtocol {
    static var reusableIdentifer = String(describing: ADTableViewCell.self)
    
    func configureCellData(data: Travel) {
        self.adLabel.text = data.title
    }
}
