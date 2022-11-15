import UIKit
import FirebaseAuth

class ProfileVC: UIViewController {

    @IBOutlet private weak var avaImageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var subView: UIImageView!

    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
    
    private func setupNavView() {
        navigationController?.navigationBar.backgroundColor = AppColor.GreenColor
        navigationController?.navigationItem.titleView?.tintColor = AppColor.WhiteColor
        navigationController?.navigationBar.tintColor = AppColor.WhiteColor

        let label = UILabel()
        label.textColor = AppColor.WhiteColor
        label.text = Localization.TitleApp.Title
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
