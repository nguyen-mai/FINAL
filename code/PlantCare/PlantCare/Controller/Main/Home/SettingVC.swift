import UIKit
import Firebase

class SettingVC: UIViewController {
    @IBOutlet private weak var subView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loginButton: ButtonWithImage!
    
    private let list = SettingViewEntity()
    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        setupTableView()
        setupView()
        setupButton()
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
    
    private func setupButton() {
        navigationController?.navigationBar.tintColor = AppColor.WhiteColor
        navigationController?.navigationBar.backgroundColor = AppColor.GreenColor
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: AppImage.Icon.Back)?.withRenderingMode(.alwaysOriginal),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backBtnTap))
      
        loginButton.setImage(UIImage(named: AppImage.Icon.CircleNext), for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Noteworthy Bold", size: 30)
        if Auth.auth().currentUser == nil {
            loginButton.setTitle(Localization.Authenticate.Login, for: .normal)
            loginButton.addTarget(self, action: #selector(loginBtnTap), for: .touchUpInside)
        } else {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            Database.database().fetchUser(withUID: uid) { (user) in
                self.user = user
                DispatchQueue.main.async {
                    self.loginButton.setTitle(user.username, for: .normal)
                    self.loginButton.addTarget(self, action: #selector(self.toProfileScreen), for: .touchUpInside)
                }
            }
        }
        
    }
}

// MARK: - Handle actions
extension SettingVC {
    @objc private func backBtnTap() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
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
        let vc = UIStoryboard(name: NameConstant.Storyboard.Home,
                              bundle: nil).instantiateVC(ProfileVC.self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SettingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellNib(type: SettingCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        let item = list.array[indexPath.row]
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
            let vc = UIStoryboard(name: NameConstant.Storyboard.Home,
                                  bundle: nil).instantiateVC(HistoryVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
