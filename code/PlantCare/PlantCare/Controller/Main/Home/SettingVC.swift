import UIKit

class SettingVC: UIViewController {
    @IBOutlet private weak var subView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var loginButton: ButtonWithImage!
    
    private let list = SettingViewEntity()
    
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
    }
    
    private func setupButton() {
        backButton.setImage(UIImage(named: AppImage.Icon.Back), for: .normal)
        backButton.addTarget(self, action: #selector(backBtnTap), for: .touchUpInside)
        
        loginButton.setTitle(Localization.Authenticate.Login, for: .normal)
        loginButton.setImage(UIImage(named: AppImage.Icon.CircleNext), for: .normal)
        loginButton.addTarget(self, action: #selector(loginBtnTap), for: .touchUpInside)
    }
}

// MARK: - Handle actions
extension SettingVC {
    @objc private func backBtnTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func loginBtnTap() {
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
