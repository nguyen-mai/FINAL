import UIKit
import Firebase
import ProgressHUD

class ClassifyResultVC: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    var model = DiseaseInfoViewEntity.Disease()
    private var arrayData = [DiseaseInfoViewEntity.ExpandedCell]()
    private var moreDetail = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        let tabBarController = self.tabBarController as! BaseTabBarController
        tabBarController.hideTabBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        let tabBarController = self.tabBarController as! BaseTabBarController
        tabBarController.showTabBar()
    }
    
    private func setupData() {
        arrayData = [
            DiseaseInfoViewEntity.ExpandedCell(title: Localization.Result.SymptomTitle, detail: self.model.symptomInfo),
            DiseaseInfoViewEntity.ExpandedCell(title: Localization.Result.ConditionTitle, detail: self.model.conditionInfo),
            DiseaseInfoViewEntity.ExpandedCell(title: Localization.Result.PreventionTitle, detail: self.model.treatmentInfo)
        ]
    }
    
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.registerCellNib(type: DiseaseInfoCell.self)
        tableView.registerCellNib(type: HeaderDiseaseInfoCell.self)
        tableView.registerCellNib(type: FooterDiseaseInfoCell.self)
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Handle actions
extension ClassifyResultVC {
    @objc private func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
}

extension ClassifyResultVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCellNib(type: HeaderDiseaseInfoCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            cell.configHeaderDiseaseInfoCell(content: model)
            return cell
        case 1...arrayData.count:
            guard let cell = tableView.dequeueReusableCellNib(type: DiseaseInfoCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            cell.configDiseaseInfoCell(content: arrayData[indexPath.row - 1], moreDetail: moreDetail)
            cell.delegate = self
            return cell
        case arrayData.count + 1:
            guard let cell = tableView.dequeueReusableCellNib(type: FooterDiseaseInfoCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ClassifyResultVC: DiseaseInfoCellDelegate, FooterDiseaseInfoCellDelegate {
    func tapExpandedButton(cell: DiseaseInfoCell) {
        moreDetail = !moreDetail
        guard let index = self.tableView.indexPath(for: cell) else {
            return
        }
        tableView.reloadRows(at: [index], with: .automatic)
    }
    
    func yesBtnTap(cell: FooterDiseaseInfoCell) {
        print("Yes")
        if Auth.auth().currentUser == nil {
            showAlert(title: Localization.Alert.NotLogIn)
        } else {
            Database.database().createRelabelImage(withImage: model.diseaseImage, plantName: model.plantName, diseaseName: model.diseaseName) { (err) in
                if err != nil {
                    ProgressHUD.showError(Localization.Notification.Error.localized())
                    return
                }
                ProgressHUD.showSucceed(Localization.Notification.Success.localized())
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func showAlert(title: String) {
        let alert = UIAlertController(title: title,
                                      message: "",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: Localization.Alert.GoLogIn.localized(),
            style: .default) { _ in
                let vc = UIStoryboard(name: NameConstant.Storyboard.Authenticate,
                                      bundle: nil).instantiateVC(LoginVC.self)
                let navBar = BaseNavigationController(rootViewController: vc)
                UIApplication.shared.windows.first?.rootViewController = navBar
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                
                UserDefaults.standard.set(EnumConstant.OnboardingStatus.LoggedIn.rawValue,
                                          forKey: NameConstant.UserDefaults.HasOnboarding)
        }
        let cancelAction = UIAlertAction(
            title: Localization.Alert.Cancel.localized(),
            style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func noBtnTapp(cell: FooterDiseaseInfoCell) {
        if Auth.auth().currentUser == nil {
            showAlert(title: Localization.Alert.NotLogIn)
        } else {
            let alertController = UIAlertController(title: Localization.Labelling.Relabelling.localized(), message: nil, preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = Localization.Labelling.PlantName.localized()
            }
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = Localization.Labelling.DiseaseName.localized()
            }
            alertController.addAction(UIAlertAction(title: Localization.Alert.OK.localized(), style: .default, handler: { [weak alertController] _ in
                guard let textFields = alertController?.textFields else { return }
                if let plantName = textFields[0].text,
                   let diseaseName = textFields[1].text {
                    Database.database().createRelabelImage(withImage: self.model.diseaseImage, plantName: plantName, diseaseName: diseaseName) { (err) in
                        if err != nil {
                            ProgressHUD.showError(Localization.Notification.Error.localized())
                            return
                        }
                        ProgressHUD.showSucceed(Localization.Notification.Success.localized())
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }))
            alertController.addAction(UIAlertAction(title: Localization.Alert.Cancel.localized(), style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
