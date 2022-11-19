import UIKit
import FirebaseAuth
import Firebase

class ProfileVC: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchCurrentUser()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupUI() {
        setupView()
        setupTableView()
        setupImageView()
        setupNavView()
    }
    
    @objc private func fetchCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().fetchUser(withUID: uid) { (user) in
            self.user = user
            print("user: \(user)")
            self.tableView.reloadData()
        }
    }
    
    private func setupNavView() {
        navigationController?.navigationBar.backgroundColor = AppColor.GreenColor
        navigationController?.navigationItem.titleView?.tintColor = AppColor.WhiteColor
        navigationController?.navigationBar.tintColor = AppColor.WhiteColor

        let label = UILabel()
        label.textColor = AppColor.WhiteColor
        label.text = Localization.Title.EditProfile.localized()
        label.font = UIFont(name: "Noteworthy Bold", size: 20)
        navigationItem.titleView = label
     
        let leftBtn = UIBarButtonItem(image: UIImage(named: AppImage.Icon.Back)?.withTintColor(AppColor.WhiteColor!), style: .plain, target: self, action: #selector(leftBtnTapped))
        navigationItem.leftBarButtonItem = leftBtn
    }
    
    @objc private func leftBtnTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        view.backgroundColor = AppColor.GreenColor
    }
    
    private func setupTableView() {
        tableView.backgroundColor = AppColor.WhiteColor
        tableView.registerCellNib(type: ProfileCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupImageView() {
        
    }
}

// MARK: - Handle action
extension ProfileVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellNib(type: ProfileCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            cell.configProfileCell(stringTitle: Localization.Profile.Username, subTitleString: user?.username ?? "")
        case 1:
            cell.configProfileCell(stringTitle: Localization.Profile.Email, subTitleString: user?.email ?? "")
        case 2:
            cell.configProfileCell(stringTitle: Localization.Profile.Password, subTitleString: "**********")
        default:
            break
        }
        cell.delegate = self
        return cell
    }
}

extension ProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ProfileVC: ProfileCellDelegate {
    func changeInfo(_ cell: ProfileCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {
            return
        }
        switch indexPath.row {
        case 0:
            let alertController = UIAlertController(title: Localization.Setting.EditingInfo.localized(), message: "", preferredStyle: .alert)

            alertController.addTextField { (textField) in
                textField.placeholder = Localization.Setting.EditingInfoPlaceholder.localized()
            }

            let cancelAction = UIAlertAction(title: Localization.Alert.Cancel, style: .cancel, handler: nil)
            let saveAction = UIAlertAction(title: Localization.Alert.Save, style: .default) { _ in
                NotificationCenter.default.post(name: NSNotification.Name.updateUserProfileFeed, object: nil)
                let inputName = alertController.textFields![0].text
                self.tableView.reloadData()
            }

            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            present(alertController, animated: true, completion: nil)
        case 1:
            let alertController = UIAlertController(title: Localization.Setting.EditingInfo.localized(), message: "", preferredStyle: .alert)

            alertController.addTextField { (textField) in
                textField.placeholder = Localization.Setting.EditingInfoPlaceholder.localized()
            }

            let cancelAction = UIAlertAction(title: Localization.Alert.Cancel, style: .cancel, handler: nil)
            let saveAction = UIAlertAction(title: Localization.Alert.Save, style: .default) { _ in
                NotificationCenter.default.post(name: NSNotification.Name.updateUserProfileFeed, object: nil)
                let inputName = alertController.textFields![0].text
                self.tableView.reloadData()
            }

            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            present(alertController, animated: true, completion: nil)
        case 2:
            let alertController = UIAlertController(title: Localization.Setting.EditingInfo.localized(), message: "", preferredStyle: .alert)

            alertController.addTextField { (textField) in
                textField.placeholder = Localization.Setting.EditingInfoPlaceholder.localized()
            }

            let cancelAction = UIAlertAction(title: Localization.Alert.Cancel, style: .cancel, handler: nil)
            let saveAction = UIAlertAction(title: Localization.Alert.Save, style: .default) { _ in
                NotificationCenter.default.post(name: NSNotification.Name.updateUserProfileFeed, object: nil)
                let inputName = alertController.textFields![0].text
                self.tableView.reloadData()
            }

            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            present(alertController, animated: true, completion: nil)
        default:
            break
        }
    }
}
