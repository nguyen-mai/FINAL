//
//  DiseaseInfoCell.swift
//  PlantCare
//
//  Created by Mai on 2022/11/7.
//

import UIKit

protocol DiseaseInfoCellDelegate: AnyObject {
    func tapExpandedButton(cell: DiseaseInfoCell)
}

class DiseaseInfoCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var expandedButton: UIButton!
    
    @IBOutlet private weak var infoLabel: UILabel!
    
    weak var delegate: DiseaseInfoCellDelegate?
    var isExpanded: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        expandedButton.tintColor = AppColor.GreenColor
        expandedButton.addTarget(self, action: #selector(expandedBtnTapped), for: .touchUpInside)
    }
    
    func configDiseaseInfoCell(content: DiseaseInfoViewEntity.ExpandedCell, moreDetail: Bool) {
        self.titleLabel.text = content.title.localized()
        self.infoLabel.text = moreDetail ? content.detail.localized() : ""
        self.expandedButton.setImage(moreDetail ? UIImage(systemName: "chevron.down") : UIImage(systemName: "chevron.up"), for: .normal)
    }
    
    @objc private func expandedBtnTapped() {
        guard let delegate = delegate else {
            return
        }
        delegate.tapExpandedButton(cell: self)
    }
}
