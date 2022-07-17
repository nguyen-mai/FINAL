import UIKit

class ChangePasswordCell: UITableViewCell {

    @IBOutlet private weak var changePassButton: UIButton!
    var delegate: TapPasswordCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    private func setupUI() {
        changePassButton.setTitle(Localization.Profile.ChangePass.localized(),
                                  for: .normal)
        changePassButton.addTarget(self, action: #selector(changePass), for: .touchUpInside)
    }
    
    @objc private func changePass() {
        guard let delegate = delegate else {
            return
        }
        delegate.changePassword(self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

protocol TapPasswordCellProtocol: AnyObject {
    func changePassword(_ cell: ChangePasswordCell)
}
