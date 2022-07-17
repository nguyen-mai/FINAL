import UIKit

class LanguageCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var underlineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(with model: LanguageViewEntity.Country) {
        titleLabel.text = model.name.localized()
        
        if model.id == AppPreferences.shared.language {
            titleLabel.textColor = AppColor.GreenColor
            underlineView.backgroundColor = AppColor.GreenColor
        } else {
            titleLabel.textColor = AppColor.BlackColor
            underlineView.backgroundColor = AppColor.LightGrayColor1
        }
    }
}
