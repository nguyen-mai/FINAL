import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {

    @IBOutlet private weak var logOutButton: UIButton!
    @IBOutlet private weak var avaImageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var subView: UIImageView!

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
        tableView.registerCellNib(type: ProfileCell.self)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellNib(type: ProfileCell.self, for: indexPath) else {
            return UITableViewCell()
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
        // create the actual alert controller view that will be the pop-up
        let alertController = UIAlertController(title: Localization.Setting.EditingInfo.localized(), message: "", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = Localization.Setting.EditingInfoPlaceholder.localized()
        }


        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: Localization.Alert.Cancel, style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: Localization.Alert.Save, style: .default) { _ in
            // this code runs when the user hits the "save" button
            let inputName = alertController.textFields![0].text
            self.tableView.reloadData()
            print(inputName)

        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }
}
