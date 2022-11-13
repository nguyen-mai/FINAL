import UIKit

protocol HeaderProfileCollectionReusableViewDelegate {
    func updateFollowButton(forUser user: User)
}

protocol HeaderProfileCollectionReusableViewDelegateSwitchSettingVC {
    func goToSettingVC()
}

class HeaderProfileCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var profileImage: CustomImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    
    var delegate: HeaderProfileCollectionReusableViewDelegate?
    var delegate2: HeaderProfileCollectionReusableViewDelegateSwitchSettingVC?
    var user: User? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clear()
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        editProfileButton.addTarget(self, action: #selector(goToSettingVC), for: .touchUpInside)
    }
    
    func updateView() {
        guard let user = user else { return }
        self.nameLabel.text = user.username
        if let profileImageUrl = user.profileImageUrl, profileImageUrl != "nil" {
            profileImage.loadImage(urlString: profileImageUrl)
        } else {
            profileImage.image = UIImage(named: AppImage.Icon.User)
        }
    }
    
    func clear() {
        self.nameLabel.text = ""
    }
    
    @objc private func goToSettingVC() {
        delegate2?.goToSettingVC()
    }
}
