import UIKit
import Firebase

protocol HeaderProfileCollectionReusableViewDelegateSwitchSettingVC {
    func goToSettingVC()
    func updateImage()
}

class HeaderProfileCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var profileImage: CustomImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    
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
        } else {
            editProfileButton.setTitle(Localization.Profile.Hello.localized(), for: .normal)
            editProfileButton.isEnabled = false
        }
    }
    
    func clear() {
        self.nameLabel.text = ""
    }
    
    @objc private func goToSettingVC() {
        delegate?.goToSettingVC()
    }
    
    @objc func handleSelectProfileImageView() {
        delegate?.updateImage()
    }
}
