//
//  SettingCell.swift
//  PlantCare
//
//  Created by Mai on 2022/7/16.
//

import UIKit

class SettingCell: UITableViewCell {
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    private func setupUI() {
        setupView()
        setupButton()
    }
    
    private func setupView() {
        cellView.layer.cornerRadius = 10
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = AppColor.LightGrayColor2?.cgColor
        cellView.layer.shadowOpacity = 0.5
        cellView.layer.shadowColor = AppColor.LightGrayColor1?.cgColor
    }
    
    private func setupButton() {
        nextButton.setImage(UIImage(named: AppImage.Icon.Arrow)?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    func configCell(with model: SettingViewEntity.Setting) {
        imgView.image = UIImage(named: model.image)
        titleLabel.text = model.title.localized()
    }

}
