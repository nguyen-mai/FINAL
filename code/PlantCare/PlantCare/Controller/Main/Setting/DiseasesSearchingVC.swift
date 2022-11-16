import UIKit
import Firebase
import ProgressHUD

class DiseasesSearchingVC: UIViewController {

    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var table: UITableView!
    
    private var data = [ClassifyingResult]()
    private let result: ClassifyingResult? = nil
    private var filteredData = [ClassifyingResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        headerView.backgroundColor = AppColor.GreenColor
        view.backgroundColor = AppColor.WhiteColor
        table.backgroundColor = AppColor.WhiteColor
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//        view.addGestureRecognizer(tap)
//        view.isUserInteractionEnabled = true
                
        filteredData = data
        configTable()
        setupSearchBar()
        setupNavBar()
        ProgressHub.shared.setupProgressHub()
        setupData()
    }
    
    private func setupNavBar() {
        let label = UILabel()
        label.textColor = AppColor.WhiteColor
        label.text = Localization.Home.SearchTitle.localized()
        label.font = UIFont(name: "Noteworthy Bold", size: 20)
        navigationItem.titleView = label
        
        navigationController?.navigationBar.tintColor = AppColor.WhiteColor
        headerView.backgroundColor = AppColor.GreenColor
    }
    
    private func setupSearchBar() {
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = Localization.Home.Search.localized()
//        searchBar.becomeFirstResponder()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.hidesBottomBarWhenPushed = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func configTable() {
        table.registerCellNib(type: DiseaseSearchingCell.self)
        table.delegate = self
        table.dataSource = self
    }
    
    private func setupData() {
        if let currentUser = Auth.auth().currentUser, !currentUser.uid.isEmpty {
            ProgressHUD.show()
            self.data.removeAll()
            self.filteredData.removeAll()
            Database.database().fetchAllClassifyingResult(completion: { data in
                print(data.count)
                self.data = data
                self.filteredData = data
                self.table.reloadData()
                ProgressHUD.dismiss()
            }, withCancel: { err in
                ProgressHUD.showError(err.localizedDescription.localized())
            })
        } else {
            self.showNotLogInAlert()
        }

    }
}

// - MARK: - Handle actions
extension DiseasesSearchingVC {
//    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
//        self.view.endEditing(true)
//    }
    
    private func showNotLogInAlert() {
        let alert = UIAlertController(title: Localization.Alert.NotLogIn.localized(),
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
            title: Localization.Alert.ReturnPage.localized(),
            style: .cancel) { _ in
                self.tabBarController?.selectedIndex = 0
                self.navigationController?.popToRootViewController(animated: true)
            }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension DiseasesSearchingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellNib(type: DiseaseSearchingCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        let item = filteredData[indexPath.row]
        cell.configDiseaseSearchingCell(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//      if editingStyle == .delete {
//        print("Deleted")
//          self.filteredData.remove(at: indexPath.row)
//          self.data.remove(at: indexPath.row)
//          Database.database().deleteClassifyingResult(resultId: filteredData[indexPath.row].uid, completion: { err in
//              if err != nil {
//                  ProgressHUD.showError(err?.localizedDescription.localized())
//              } else {
//                  ProgressHUD.showSucceed(Localization.Notification.DeletedSuccess.localized())
//              }
//          })
//          self.table.deleteRows(at: [indexPath], with: .automatic)
//      }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: NameConstant.Storyboard.Home,
                              bundle: nil).instantiateVC(DetailDiseaseVC.self)
        let item = filteredData[indexPath.row]
        var threatLevel = ""
        var aboutTxt = ""
        var conditionTxt = ""
        var treatmentTxt = ""
        var type = ""
//        vc.model = item
        switch item.diseaseName {
        case Localization.AppleDisease.AppleScab.localized():
            type = Localization.Result.Fungus.localized()
            threatLevel = Localization.Result.HighLevel.localized()
            aboutTxt = Localization.AppleDisease.AppleScabAbout.localized()
            conditionTxt = Localization.AppleDisease.AppleScabCondition.localized()
            treatmentTxt = Localization.AppleDisease.AppleScabTreatment.localized()
            
        case Localization.AppleDisease.AppleBlackRot.localized():
            type = Localization.Result.Fungus.localized()
            threatLevel = Localization.Result.HighLevel.localized()
            aboutTxt = Localization.AppleDisease.AppleBlackRotAbout.localized()
            conditionTxt = Localization.AppleDisease.AppleBlackRotCondition.localized()
            treatmentTxt = Localization.AppleDisease.AppleBlackRotTreatment.localized()
            
        case Localization.AppleDisease.AppleCedar.localized():
            type = Localization.Result.Fungus.localized()
            threatLevel = Localization.Result.HighLevel.localized()
            aboutTxt = Localization.AppleDisease.AppleCedarAbout.localized()
            conditionTxt = Localization.AppleDisease.AppleCedarCondition.localized()
            treatmentTxt = Localization.AppleDisease.AppleCedarTreatment.localized()
            
        case Localization.Result.Healthy.localized():
            break
            
        case "Cherry Powdery Mildew".localized():
            type = Localization.Result.Fungus.localized()
            threatLevel = Localization.Result.HighLevel.localized()
            
        case Localization.CornDisease.CornGraySpot.localized():
            type = Localization.Result.Fungus.localized()
            threatLevel = Localization.Result.HighLevel.localized()
            aboutTxt = Localization.CornDisease.CornGraySpotAbout.localized()
            conditionTxt = Localization.CornDisease.CornGraySpotCondition.localized()
            treatmentTxt = Localization.CornDisease.CornGraySpotTreatment.localized()
            
        case Localization.CornDisease.CornRust.localized():
            type = Localization.Result.Fungus.localized()
            threatLevel = Localization.Result.HighLevel.localized()
            aboutTxt = Localization.CornDisease.CornRustAbout.localized()
            conditionTxt = Localization.CornDisease.CornRustCondition.localized()
            treatmentTxt = Localization.CornDisease.CornRustTreatment.localized()
            
        case Localization.CornDisease.CornNorthenBlight.localized():
            type = Localization.Result.Fungus.localized()
            threatLevel = Localization.Result.HighLevel.localized()
            aboutTxt = Localization.CornDisease.CornNorthenBlightAbout.localized()
            conditionTxt = Localization.CornDisease.CornNorthenBlightCondition.localized()
            treatmentTxt = Localization.CornDisease.CornNorthenBlightTreatment.localized()
            
//        case "Grape___Black_rot":
//            predictedResult = "Black Rot".localized()
//            plantType = "Grape".localized()
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Grape___Esca_(Black_Measles)":
//            predictedResult = "Grape Esca"
//            plantType = "Grape"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Grape___Leaf_blight_(Isariopsis_Leaf_Spot)":
//            predictedResult = "Grape Leaf Blight"
//            plantType = "Grape"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.Fungus.localized()
//
//        case "Orange___Haunglongbing_(Citrus_greening)":
//            predictedResult = "Orange Haunglongbing"
//            plantType = "Orange"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Peach___Bacterial_spot":
//            predictedResult = "Peach Bacterial Spot"
//            plantType = "Peach"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Pepper,_bell___Bacterial_spot":
//            predictedResult = "Bacterial Spot"
//            plantType = "Pepper Bell"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Potato___Early_blight":
//            predictedResult = "Early Blight"
//            plantType = "Potato"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Potato___Late_blight":
//            predictedResult = "Potato Late Blight"
//            plantType = "Potato"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Squash___Powdery_mildew":
//            predictedResult = "Squash Powdery Mildew"
//            plantType = "Squash"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Strawberry___Leaf_scorch":
//            predictedResult = "Strawberry Leaf Scorch"
//            plantType = "Strawberry"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Tomato___Bacterial_spot":
//            predictedResult = "Tomato Bacterial Spot"
//            plantType = "Tomato"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Tomato___Early_blight":
//            predictedResult = "Tomato Early Blight"
//            plantType = "Tomato"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Tomato___Late_blight":
//            predictedResult = "Tomato Late Blight"
//            plantType = "Tomato"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Tomato___Leaf_Mold":
//            predictedResult = "Tomato Leaf Mold"
//            plantType = "Tomato"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Tomato___Septoria_leaf_spot":
//            predictedResult = "Tomato Septoria Leaf Spot"
//            plantType = "Tomato"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Tomato___Spider_mites Two-spotted_spider_mite":
//            predictedResult = "Tomato Spider Mites"
//            plantType = "Tomato"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Tomato___Target_Spot":
//            predictedResult = "Tomato Target Spot"
//            plantType = "Tomato"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Tomato___Tomato_Yellow_Leaf_Curl_Virus":
//            predictedResult = "Tomato Yellow Leaf Curl Virus"
//            plantType = "Tomato"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
//
//        case "Tomato___Tomato_mosaic_virus":
//            predictedResult = "Tomato Mosaic Virus"
//            plantType = "Tomato"
//            type = Localization.Result.Fungus.localized()
//            threatLevel = Localization.Result.HighLevel.localized()
            
        default:
            break
        }
//        type = Localization.Result.Fungus.localized()
//        threatLevel = Localization.Result.HighLevel.localized()
//        aboutTxt = Localization.CornDisease.CornGraySpotAbout.localized()
//        conditionTxt = Localization.CornDisease.CornGraySpotCondition.localized()
//        treatmentTxt = Localization.CornDisease.CornGraySpotTreatment.localized()
        vc.model = DiseaseInfoViewEntity.Disease(diseaseImage: UIImage(named: AppImage.DiseaseImage.AppleBlackRot) ?? UIImage(),
                                                 diseaseName: item.diseaseName,
                                                 plantName: item.plantName,
                                                 typeDisease: type,
                                                 threatLevel: threatLevel,
                                                 symptomInfo: aboutTxt,
                                                 conditionInfo: conditionTxt,
                                                 treatmentInfo: treatmentTxt,
                                                 certainty: item.certainty)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension DiseasesSearchingVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        if searchText == "" {
            filteredData = data
        }
        else {
            let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            for name in data {
                if name.diseaseName.lowercased().contains(text) {
                    filteredData.append(name)
                }
            }
        }
        self.table.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}


