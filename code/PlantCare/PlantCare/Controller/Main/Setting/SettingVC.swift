import UIKit
import Firebase

class SettingVC: UIViewController {
    @IBOutlet private weak var subView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loginButton: ButtonWithImage!
    @IBOutlet private weak var logOutBtn: UIButton!
    
    private var list = SettingViewEntity()
    private var listSetting = [SettingViewEntity.Setting]()
    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tabBarController = self.tabBarController as! BaseTabBarController
        tabBarController.hideTabBar()
    }
    
    private func setupUI() {
        setupTableView()
        setupView()
        setupButton()
        setupNavView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setupButton), name: NSNotification.Name.updateUserProfileFeed, object: nil)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupView() {
        subView.backgroundColor = AppColor.GreenColor
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc private func setupButton() {
        loginButton.setImage(UIImage(named: AppImage.Icon.CircleNext), for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Noteworthy Bold", size: 20)
        if Auth.auth().currentUser == nil {
            loginButton.setTitle(Localization.Authenticate.Login.localized(), for: .normal)
            loginButton.addTarget(self, action: #selector(loginBtnTap), for: .touchUpInside)
            logOutBtn.isHidden = true
            listSetting = list.notLoginArray
        } else {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            listSetting = list.loginedArray
            Database.database().fetchUser(withUID: uid) { (user) in
                self.user = user
                DispatchQueue.main.async {
                    self.loginButton.setTitle(user.username, for: .normal)
                    self.loginButton.addTarget(self, action: #selector(self.toProfileScreen), for: .touchUpInside)
                    self.logOutBtn.isHidden = false
                }
            }
        }
        
        logOutBtn.setTitle(Localization.Authenticate.LogOut.localized(),
                              for: .normal)
        logOutBtn.backgroundColor = AppColor.WhiteColor
        logOutBtn.layer.borderWidth = 2
        logOutBtn.backgroundColor = AppColor.GreenColor
        logOutBtn.layer.borderColor = AppColor.GreenColor?.cgColor
        logOutBtn.layer.cornerRadius = logOutBtn.frame.height / 2
        logOutBtn.setTitleColor(AppColor.WhiteColor, for: .normal)
        logOutBtn.addTarget(self, action: #selector(logOutBtnTap), for: .touchUpInside)
        // shadow
        logOutBtn.layer.shadowColor = UIColor.black.cgColor
        logOutBtn.layer.shadowOffset = CGSize(width: 5, height: 5)
        logOutBtn.layer.shadowOpacity = 0.5
        logOutBtn.layer.shadowRadius = 5.0
    }
    
    private func setupNavView() {
        navigationController?.navigationBar.backgroundColor = AppColor.GreenColor
        navigationController?.navigationItem.titleView?.tintColor = AppColor.WhiteColor
        navigationController?.navigationBar.tintColor = AppColor.WhiteColor

        let label = UILabel()
        label.textColor = AppColor.WhiteColor
        label.text = ""
        label.font = UIFont(name: "Noteworthy Bold", size: 20)
        navigationItem.titleView = label
     
        let leftBtn = UIBarButtonItem(image: UIImage(named: AppImage.Icon.Back)?.withTintColor(AppColor.WhiteColor!), style: .plain, target: self, action: #selector(leftBtnTapped))
        navigationItem.leftBarButtonItem = leftBtn
    }
    
    @objc private func leftBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Handle actions
extension SettingVC {
    @objc private func loginBtnTap() {
        let vc = UIStoryboard(name: NameConstant.Storyboard.Authenticate,
                              bundle: nil).instantiateVC(LoginVC.self)
        let navBar = BaseNavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = navBar
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        UserDefaults.standard.set(EnumConstant.OnboardingStatus.LoggedIn.rawValue,
                                  forKey: NameConstant.UserDefaults.HasOnboarding)
    }
    
    @objc private func toProfileScreen() {
        let vc = UIStoryboard(name: NameConstant.Storyboard.Forum,
                              bundle: nil).instantiateVC(AccountVC.self)
        vc.uid = Auth.auth().currentUser?.uid ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func logOutBtnTap() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Localization.Alert.LogOut.localized(), style: .destructive, handler: { _ in
            try! Auth.auth().signOut()
            let vc = UIStoryboard(name: NameConstant.Storyboard.Authenticate,
                                  bundle: nil).instantiateVC(LoginVC.self)
            let navBar = BaseNavigationController(rootViewController: vc)
            UIApplication.shared.windows.first?.rootViewController = navBar
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
            UserDefaults.standard.set(EnumConstant.OnboardingStatus.LoggedIn.rawValue,
                                      forKey: NameConstant.UserDefaults.HasOnboarding)
        }))
        alert.addAction(UIAlertAction(title: Localization.Alert.Cancel.localized(), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension SettingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSetting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellNib(type: SettingCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        let item = list.loginedArray[indexPath.row]
        cell.configCell(with: item)
        return cell
    }
}

extension SettingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = indexPath.row
        switch item {
        case 0:
            let vc = UIStoryboard(name: NameConstant.Storyboard.Home,
                                  bundle: nil).instantiateVC(LanguageVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = UIStoryboard(name: NameConstant.Storyboard.Forum,
                                  bundle: nil).instantiateVC(AccountVC.self)
            vc.uid = Auth.auth().currentUser?.uid ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = UIStoryboard(name: NameConstant.Storyboard.Home,
                                  bundle: nil).instantiateVC(DiseasesSearchingVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = UIStoryboard(name: NameConstant.Storyboard.Home,
                                  bundle: nil).instantiateVC(ProfileVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
