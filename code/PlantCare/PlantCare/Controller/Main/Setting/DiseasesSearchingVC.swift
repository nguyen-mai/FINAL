import UIKit
import Firebase
import ProgressHUD

class DiseasesSearchingVC: UIViewController {

    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var table: UITableView!
    @IBOutlet private weak var noDataLabel: UILabel!
    
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
        setupLabel()
    }
    
    private func setupLabel() {
        noDataLabel.text = ""
        noDataLabel.isHidden = true
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
                if self.filteredData.count > 0 {
                    self.noDataLabel.isHidden = true
                    self.table.isHidden = false
                    self.table.reloadData()
                } else {
                    self.noDataLabel.text = Localization.Result.NoResult.localized()
                    self.noDataLabel.isHidden = false
                    self.table.isHidden = false
                }
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
        noDataLabel.isHidden = filteredData.count > 0
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          Database.database().deleteClassifyingResult(resultId: filteredData[indexPath.row].uid, completion: { err in
              if err != nil {
                  ProgressHUD.showError(err?.localizedDescription.localized())
              } else {
                  self.data.remove(at: indexPath.row)
                  self.filteredData.remove(at: indexPath.row)
                  self.table.deleteRows(at: [indexPath], with: .automatic)
                  self.table?.reloadData()
                  ProgressHUD.showSucceed(Localization.Notification.DeletedSuccess.localized())
              }
          })
      }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: NameConstant.Storyboard.Home,
                              bundle: nil).instantiateVC(DetailDiseaseVC.self)
        let item = filteredData[indexPath.row]
        var threatLevel = ""
        var aboutTxt = ""
        var treatmentTxt = ""
        var type = ""
//        vc.model = item
        switch item.diseaseName.localized() {
        case Localization.AppleDisease.AppleScab.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.AppleDisease.AppleScabAbout.localized()
            treatmentTxt = Localization.AppleDisease.AppleScabTreatment.localized()
            
        case Localization.AppleDisease.AppleBlackRot.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.AppleDisease.AppleBlackRotAbout.localized()
            treatmentTxt = Localization.AppleDisease.AppleBlackRotTreatment.localized()
            
        case Localization.AppleDisease.AppleCedar.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.AppleDisease.AppleCedarAbout.localized()
            treatmentTxt = Localization.AppleDisease.AppleCedarTreatment.localized()
            
        case Localization.Cherry.CherryPowderyMildew.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Cherry.CherryPowderyMildewAbout.localized()
            treatmentTxt = Localization.Cherry.CherryPowderyMildewTreatment.localized()
            
        case Localization.CornDisease.CornGraySpot.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.CornDisease.CornGraySpotAbout.localized()
            treatmentTxt = Localization.CornDisease.CornGraySpotTreatment.localized()
            
        case Localization.CornDisease.CornRust.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.CornDisease.CornRustAbout.localized()
            treatmentTxt = Localization.CornDisease.CornRustTreatment.localized()
            
        case Localization.CornDisease.CornNorthenBlight.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.CornDisease.CornNorthenBlightAbout.localized()
            treatmentTxt = Localization.CornDisease.CornNorthenBlightTreatment.localized()
            
        case Localization.Grape.BlackRot.BlackRot.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Grape.BlackRot.BlackRotAbout.localized()
            treatmentTxt = Localization.Grape.BlackRot.BlackRotTreatment.localized()
            
        case Localization.Grape.Esca.Esca.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Grape.Esca.EscaAbout.localized()
            treatmentTxt = Localization.Grape.Esca.EscaTreatment.localized()
            
        case Localization.Grape.GrapeLeafBlight.GrapeLeafBlight.localized():
            type = Localization.Result.Fungus.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Grape.GrapeLeafBlight.GrapeLeafBlightAbout.localized()
            treatmentTxt = Localization.Grape.GrapeLeafBlight.GrapeLeafBlightTreatment.localized()
            
        case Localization.Orange.OrangeHaunglongbing.localized():
            type = Localization.Result.Bacterial.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Orange.OrangeHaunglongbingAbout.localized()
            treatmentTxt = Localization.Orange.OrangeHaunglongbingTreatment.localized()
            
        case Localization.Peach.PeachBacterialSpot.localized():
            type = Localization.Result.Bacterial.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Peach.PeachBacterialSpotAbout.localized()
            treatmentTxt = Localization.Peach.PeachBacterialSpotTreatment.localized()
            
        case Localization.PepperBell.BacterialSpot.BacterialSpot.localized():
            type = Localization.Result.Bacterial.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.PepperBell.BacterialSpot.BacterialSpotAbout.localized()
            treatmentTxt = Localization.PepperBell.BacterialSpot.BacterialSpotTreatment.localized()
            
        case Localization.Potato.EarlyBlight.EarlyBlight.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Potato.EarlyBlight.EarlyBlightAbout.localized()
            treatmentTxt = Localization.Potato.EarlyBlight.EarlyBlightTreatment.localized()
            
        case Localization.Potato.LateBlight.LateBlight.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Potato.LateBlight.LateBlightAbout.localized()
            treatmentTxt = Localization.Potato.LateBlight.LateBlightTreatment.localized()
            
        case Localization.Squash.SquashPowderyMildew.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Squash.SquashPowderyMildewAbout.localized()
            treatmentTxt = Localization.Squash.SquashPowderyMildewTreatment.localized()
            
        case Localization.Strawberry.StrawberryLeafScorch.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Strawberry.StrawberryLeafScorchAbout.localized()
            treatmentTxt = Localization.Strawberry.StrawberryLeafScorchTreatment.localized()
            
        case Localization.Tomato.TomatoBacterialSpot.TomatoBacterialSpot.localized():
            type = Localization.Result.Bacterial.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Tomato.TomatoBacterialSpot.TomatoBacterialSpotAbout.localized()
            treatmentTxt = Localization.Tomato.TomatoBacterialSpot.TomatoBacterialSpotTreatment.localized()
            
        case Localization.Tomato.TomatoEarlyBlight.TomatoEarlyBlight.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Tomato.TomatoEarlyBlight.TomatoEarlyBlighAbout.localized()
            treatmentTxt = Localization.Tomato.TomatoEarlyBlight.TomatoEarlyBlighTreatment.localized()
            
        case Localization.Tomato.TomatoLateBlight.TomatoLateBlight.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Tomato.TomatoLateBlight.TomatoLateBlightAbout.localized()
            treatmentTxt = Localization.Tomato.TomatoLateBlight.TomatoLateBlightTreatment.localized()
            
        case Localization.Tomato.TomatoLeafMold.TomatoLeafMold.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Tomato.TomatoLeafMold.TomatoLeafMoldAbout.localized()
            treatmentTxt = Localization.Tomato.TomatoLeafMold.TomatoLeafMoldTreatment.localized()
            
        case Localization.Tomato.TomatoSeptoriaLeafSpot.TomatoSeptoriaLeafSpot.localized():
            type = Localization.Result.Mold.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Tomato.TomatoSeptoriaLeafSpot.TomatoSeptoriaLeafSpotAbout.localized()
            treatmentTxt = Localization.Tomato.TomatoSeptoriaLeafSpot.TomatoSeptoriaLeafSpotTreatment.localized()
            
        case Localization.Tomato.TomatoSpiderMites.TomatoSpiderMites.localized():
            type = Localization.Result.Mite.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Tomato.TomatoSpiderMites.TomatoSpiderMitesAbout.localized()
            treatmentTxt = Localization.Tomato.TomatoSpiderMites.TomatoSpiderMitesTreatment.localized()
            
        case Localization.Tomato.TomatoTargetSpot.TomatoTargetSpot.localized():
            type = Localization.Result.Fungi.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Tomato.TomatoTargetSpot.TomatoTargetSpotAbout.localized()
            treatmentTxt = Localization.Tomato.TomatoTargetSpot.TomatoTargetSpotTreatment.localized()
            
        case Localization.Tomato.TomatoYellowLeafCurlVirus.TomatoYellowLeafCurlVirus.localized():
            type = Localization.Result.Virus.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Tomato.TomatoYellowLeafCurlVirus.TomatoYellowLeafCurlVirusAbout.localized()
            treatmentTxt = Localization.Tomato.TomatoYellowLeafCurlVirus.TomatoYellowLeafCurlVirusTreatment.localized()
            
        case Localization.Tomato.TomatoMosaicVirus.TomatoMosaicVirus.localized():
            type = Localization.Result.Virus.localized()
            threatLevel = Localization.Result.MediumLevel.localized()
            aboutTxt = Localization.Tomato.TomatoMosaicVirus.TomatoMosaicVirusAbout.localized()
            treatmentTxt = Localization.Tomato.TomatoMosaicVirus.TomatoMosaicVirusTreatment.localized()
        
        default:
            break
        }

        vc.model = DiseaseInfoViewEntity.Disease(diseaseImage: UIImage(),
                                                 diseaseName: item.diseaseName,
                                                 plantName: item.plantName,
                                                 typeDisease: type,
                                                 threatLevel: threatLevel,
                                                 symptomInfo: aboutTxt,
                                                 treatmentInfo: treatmentTxt,
                                                 certainty: item.certainty)
        vc.urlImage = item.imageUrl
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


