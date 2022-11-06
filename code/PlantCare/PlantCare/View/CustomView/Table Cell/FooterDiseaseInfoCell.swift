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
    
    weak var delegate: FooterDiseaseInfoCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupButton()
    }
    
    private func setupButton() {
        yesButton.setTitle(Localization.Alert.Yes.localized(), for: .normal)
        noButton.setTitle(Localization.Alert.No.localized(), for: .normal)
        
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
