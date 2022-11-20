import UIKit
import Firebase

protocol HeaderProfileCollectionReusableViewDelegateSwitchSettingVC {
    func goToSettingVC()
    func updateImage()
    func gotoEditProfile()
}

class HeaderProfileCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet private weak var profileImage: CustomImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var editProfileButton: UIButton!
    @IBOutlet private weak var editButton: UIButton!
    
    var delegate: HeaderProfileCollectionReusableViewDelegateSwitchSettingVC?
    var user: User? {
        didSet {
            updateView()
        }
    }
    var changedImage: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clear()
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
        profileImage.layer.borderWidth = 0.5
        NotificationCenter.default.addObserver(self, selector: #selector(handleRefresh), name: NSNotification.Name.updateUserProfileFeed, object: nil)
    }
    
    func updateView() {
        guard let user = user else { return }
        self.nameLabel.text = user.username
        if let profileImageUrl = user.profileImageUrl, profileImageUrl != "nil" {
            profileImage.loadImage(urlString: profileImageUrl)
        } else {
            profileImage.image = UIImage(named: AppImage.Icon.User)
        }
        if user.uid == Auth.auth().currentUser?.uid {
            editProfileButton.setTitle(Localization.Profile.EditPost.localized(), for: .normal)
            editProfileButton.addTarget(self, action: #selector(goToSettingVC), for: .touchUpInside)
            editProfileButton.isEnabled = true
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectProfileImageView))
            profileImage.addGestureRecognizer(tapGesture)
            profileImage.isUserInteractionEnabled = true
            
            if let changedImage = changedImage, changedImage != UIImage(named: AppImage.Icon.User) {
                profileImage.image = changedImage
            }
            
            editButton.isHidden = false
            editButton.setImage(UIImage(named: AppImage.Icon.Pencil), for: .normal)
            editButton.addTarget(self, action: #selector(tapBtn), for: .touchUpInside)
        } else {
            editProfileButton.setTitle(Localization.Profile.Hello.localized(), for: .normal)
            editProfileButton.isEnabled = false
            editButton.isHidden = true
        }
    }
    
    func clear() {
        self.nameLabel.text = ""
    }
    
    @objc private func tapBtn() {
        delegate?.gotoEditProfile()
    }
    
    @objc private func goToSettingVC() {
        delegate?.goToSettingVC()
    }
    
    @objc func handleSelectProfileImageView() {
        delegate?.updateImage()
    }
    
    @objc func handleRefresh() {
        if let changedImage = changedImage, changedImage != UIImage(named: AppImage.Icon.User) {
            profileImage.image = changedImage
        }
    }
}
