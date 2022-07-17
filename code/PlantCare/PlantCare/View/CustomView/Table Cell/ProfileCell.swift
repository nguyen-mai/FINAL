import UIKit

class ProfileCell: UITableViewCell {
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var subTitle: UILabel!
    @IBOutlet private weak var fixButton: UIButton!
    @IBOutlet private weak var underlineView: UIView!
    
    var delegate: TapProfileCellProtocol?
    private let titleArry: [String] = [
        Localization.Profile.UserName.localized(),
        Localization.Profile.Email.localized()
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    private func setupUI() {
        setupUnderlineView()
        setupButton()
        setupLabel()
    }
    
    private func setupUnderlineView() {
        underlineView.backgroundColor = AppColor.LightGrayColor1
    }
    
    private func setupButton() {
        fixButton.setImage(UIImage(named: AppImage.Icon.Pencil)?.withRenderingMode(.alwaysOriginal),
                           for: .normal)
        fixButton.addTarget(self, action: #selector(changeInfo), for: .touchUpInside)
    }
    
    private func setupLabel() {
        title.textColor = AppColor.GrayColor
        subTitle.textColor = AppColor.BlackColor
    }
    
    @objc private func changeInfo() {
        guard let delegate = delegate else {
            return
        }
        delegate.changeInfo(self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configProfileCell(with model: User) {
        guard let title = title.text else {
            return
        }
        if title.contains("User") {
            subTitle.text = model.username
        } else {
            subTitle.text = model.email
        }
    }
}

protocol TapProfileCellProtocol: AnyObject {
    func changeInfo(_ cell: ProfileCell)
}
