import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {

    @IBOutlet private weak var logOutButton: UIButton!
    @IBOutlet private weak var avaImageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var subView: UIImageView!
    @IBOutlet private weak var backButton: UIButton!
    
    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() {
        setupButton()
        setupView()
        setupTableView()
        setupImageView()
    }
    
    private func setupView() {
        view.backgroundColor = AppColor.GreenColor
        subView.backgroundColor = AppColor.LightGrayColor2
    }
    
    private func setupTableView() {
        tableView.backgroundColor = AppColor.LightGrayColor2
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupImageView() {
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
                
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupButton() {
        backButton.setImage(UIImage(named: AppImage.Icon.Back)?.withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.addTarget(self, action: #selector(backBtnTap), for: .touchUpInside)
        
        logOutButton.setTitle(Localization.Authenticate.LogOut.localized(),
                              for: .normal)
        logOutButton.backgroundColor = AppColor.WhiteColor
        logOutButton.setTitleColor(AppColor.RedColor, for: .normal)
        logOutButton.addTarget(self, action: #selector(logOutBtnTap), for: .touchUpInside)
    }
}

extension ProfileVC {
    @objc private func backBtnTap() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func logOutBtnTap() {
        let alert = UIAlertController(
            title: Localization.Alert.LogOut.localized(),
            message: Localization.Alert.LogoutMessage.localized(),
            preferredStyle: .alert)
        let cancelAction = UIAlertAction(
            title: Localization.Alert.Cancel.localized(),
            style: .cancel)
        let okAction = UIAlertAction(
            title: Localization.Alert.LogOut.localized().uppercased(),
            style: .default) { _ in
                try! Auth.auth().signOut()
                let vc = UIStoryboard(name: NameConstant.Storyboard.Home,
                                      bundle: nil).instantiateVC(SettingVC.self)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProfileVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCellNib(type: ProfileCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCellNib(type: ChangePasswordCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}

extension ProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
