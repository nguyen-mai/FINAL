//
//  ReferenceDiseaseInfoCell.swift
//  PlantCare
//
//  Created by Mai on 2022/11/7.
//

import UIKit

protocol FooterDiseaseInfoCellDelegate: AnyObject {
    func yesBtnTap(cell: FooterDiseaseInfoCell)
    func noBtnTapp(cell: FooterDiseaseInfoCell)
}

class FooterDiseaseInfoCell: UITableViewCell {
    
    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    
    weak var delegate: FooterDiseaseInfoCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupButton()
        setTitle()
    }
    
    private func setTitle() {
        titleLabel.text = Localization.Home.ReferenceResult.localized()
//        titleLabel.font = AppFont.medium.size(12)
        titleLabel.textColor = AppColor.DarkGray
    }
    
    private func setupButton() {
        yesButton.layer.cornerRadius = 15
        noButton.layer.cornerRadius = 15
        
        yesButton.backgroundColor = AppColor.GreenColor
        yesButton.setTitleColor(AppColor.WhiteColor, for: .normal)
        
        noButton.layer.borderColor = AppColor.GreenColor?.cgColor
        noButton.layer.borderWidth = 2
        
        yesButton.setTitle(Localization.Alert.Yes.localized(), for: .normal)
        noButton.setTitle(Localization.Alert.No.localized(), for: .normal)
        noButton.setTitleColor(AppColor.GreenColor, for: .normal)
        
//        yesButton.titleLabel?.font = AppFont.bold.size(12)
//        noButton.titleLabel?.font = AppFont.bold.size(12)
        
        yesButton.addTarget(self, action: #selector(yesButtonTap), for: .touchUpInside)
        noButton.addTarget(self, action: #selector(noButtonTap), for: .touchUpInside)
    }
    
    @objc private func yesButtonTap() {
        guard let delegate = delegate else {
            return
        }
        delegate.yesBtnTap(cell: self)
    }
    
    @objc private func noButtonTap() {
        guard let delegate = delegate else {
            return
        }
        delegate.noBtnTapp(cell: self)
    }
}
