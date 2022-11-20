import UIKit
import AVKit
import CoreML
import Vision
import ProgressHUD

class HomeVC: UIViewController {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var cameraBtn: UIButton!
    @IBOutlet private weak var helpView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var image1: UIImageView!
    @IBOutlet private weak var nextImage1: UIImageView!
    @IBOutlet private weak var image2: UIImageView!
    @IBOutlet private weak var nextImage2: UIImageView!
    @IBOutlet private weak var image3: UIImageView!
    @IBOutlet private weak var label1: UILabel!
    @IBOutlet private weak var label2: UILabel!
    @IBOutlet private weak var label3: UILabel!
    @IBOutlet private weak var allButton: UIButton!
    @IBOutlet private weak var firstTitleLabel: UILabel!
    @IBOutlet weak var secondTitleLabel: UILabel!
    @IBOutlet private weak var heightConstraintScrollView: NSLayoutConstraint!
        
    private var titleRightBtn = ""
    private var blogs = DiseaseInfoViewEntity()
    private var timer = Timer()
    private var currentPage: Int = 0
    let screenSize: CGRect = UIScreen.main.bounds
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tabBarController = self.tabBarController as! BaseTabBarController
        tabBarController.showTabBar()
    }
   
    private func setupUI() {
        setupNavigationItem()
        setupTextField()
        setupCollectionView()
        setupImageView()
        setupButton()
        setupView()
        setupLabel()
        setupNavBar()
        setupConstraint()
        ProgressHub.shared.setupProgressHub()
    }
    
    private func setupConstraint() {
        switch UIDevice().type {
            case .iPhoneSE, .iPhone5, .iPhone5S:
            heightConstraintScrollView.constant = 100
            case .iPhone6, .iPhone7, .iPhone8, .iPhone6S, .iPhoneX:
            heightConstraintScrollView.constant = 90
            case .iPhone11, .iPhone12, .iPhone13:
            heightConstraintScrollView.constant = 0
            default:
            heightConstraintScrollView.constant = 0
        }
    }
    
    private func setupNavBar() {
        UINavigationBarAppearance().backgroundColor = AppColor.GreenColor
        navigationController?.navigationBar.tintColor = AppColor.WhiteColor
        navigationController?.navigationBar.backgroundColor = AppColor.GreenColor
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: AppImage.Icon.Menu)?.withTintColor(AppColor.WhiteColor!),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(leftButtonTap))
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 5,
                                              target: self,
                                              selector: #selector(self.changeImage),
                                              userInfo: nil, repeats: true)
        }
    }
    
    private func setupTextField() {
        CustomTextField.shared.searchTextField(textfield: searchTextField,
                                               placeholder: Localization.Home.Search.localized(),
                                               icon: AppImage.Icon.Search)
        searchTextField.isUserInteractionEnabled = false
    }
    
    private func setupImageView() {
        image1.image = UIImage(named: AppImage.Icon.Scan)
        image2.image = UIImage(named: AppImage.Icon.Paper)
        image3.image = UIImage(named: AppImage.Icon.Care)
        
        nextImage1.image = UIImage(named: AppImage.Icon.Next)
        nextImage2.image = UIImage(named: AppImage.Icon.Next)
    }
    
    private func setupButton() {
        cameraBtn.layer.cornerRadius = 20
        cameraBtn.setTitle(Localization.Home.TakePicture.localized(), for: .normal)
        cameraBtn.setTitleColor(AppColor.WhiteColor, for: .normal)
        cameraBtn.addTarget(self, action: #selector(cameraBtnTap), for: .touchUpInside)
        
        allButton.setTitle(Localization.Home.All.localized(), for: .normal)
        allButton.setTitleColor(AppColor.GreenColor, for: .normal)
        allButton.addTarget(self, action: #selector(searchTextFieldTap), for: .touchUpInside)
    }
    
    private func setupView() {
        view.backgroundColor = AppColor.LightGrayColor2
        helpView.layer.cornerRadius = 20
        helpView.layer.shadowColor = UIColor.lightGray.cgColor
        self.view.backgroundColor = AppColor.LightGrayColor4
    }
    
    private func setupLabel() {
        firstTitleLabel.text = Localization.Home.Heal.localized()
        secondTitleLabel.text = Localization.Home.References.localized()
        
        titleLabel.text = Localization.TitleApp.Title.localized()
        titleLabel.font = UIFont(name: "Noteworthy Bold", size: 35)
        titleLabel.textColor = UIColor.white
        
        label1.text = Localization.Home.TakePicture.localized()
        label1.textColor = AppColor.BlackColor
        label1.textAlignment = .center
    
        label2.text = Localization.Home.Diagnois.localized()
        label2.textColor = AppColor.BlackColor
        label2.textAlignment = .center
        
        label3.text = Localization.Home.Medicine.localized()
        label3.textColor = AppColor.BlackColor
        label3.textAlignment = .center
    }
    
    private func setupNavigationItem() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

// MARK: - Handle actions
extension HomeVC {
    @objc private func cameraBtnTap() {
        let ac = UIAlertController(title: Localization.Home.SelectImg.localized(),
                                   message: nil, preferredStyle: .actionSheet)
        let photoBtn = UIAlertAction(title: Localization.Home.Photo.localized(),
                                     style: .default, handler: handleOpenPhoto)
        let cameraBtn = UIAlertAction(title: Localization.Home.Camera.localized(),
                                      style: .default, handler: handleOpenCamera)
        let cancelBtn = UIAlertAction(title: Localization.Home.Cancel.localized(),
                                      style: .cancel, handler: nil)
        ac.addAction(photoBtn)
        ac.addAction(cameraBtn)
        ac.addAction(cancelBtn)
        
        present(ac, animated: true, completion: nil)
    }
    
    @objc private func handleOpenPhoto(_ action: UIAlertAction) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc private func handleOpenCamera(_ action: UIAlertAction) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc private func leftButtonTap() {
        let vc = UIStoryboard(name: NameConstant.Storyboard.Home,
                              bundle: nil).instantiateVC(SettingVC.self)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func searchTextFieldTap() {
        let vc = UIStoryboard(name: NameConstant.Storyboard.Home,
                              bundle: nil).instantiateVC(DiseasesListVC.self)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func changeImage() {
        if currentPage < blogs.array.count {
            let index = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            currentPage += 1
        } else {
            currentPage = 0
            let index = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            currentPage = 1
        }
    }
    
    @IBAction private func tapTextField(_ sender: Any) {
        let vc = UIStoryboard(name: NameConstant.Storyboard.Home,
                              bundle: nil).instantiateVC(DiseasesListVC.self)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            guard let model = try? VNCoreMLModel(for: ClassifierModel(configuration: MLModelConfiguration()).model) else {
                ProgressHUD.showError(Localization.Notification.Error.localized())
                fatalError("Unable to load model")
            }
            
            let request = VNCoreMLRequest(model: model) {[weak self] request, error in
                guard let results = request.results as? [VNClassificationObservation],
                      let topResult = results.first, let prediction = results.first?.confidence
                    else {
                        ProgressHUD.showError(Localization.Notification.Error.localized())
                        fatalError("Unexpected results")
                }
//                let predconfidence = String(format: "%.02f%", prediction * 100)
                let predconfidence = Double(round(100 * prediction) / 100)
                var predictedResult = topResult.identifier
                var plantType: String = Localization.Result.None.localized()
                var type: String = Localization.Result.None.localized()
                var threatLevel: String  = Localization.Result.None.localized()
                var aboutTxt: String = Localization.Result.None.localized()
                var treatmentTxt: String = Localization.Result.None.localized()
                switch predictedResult {
                case "Apple___Apple_scab":
                    predictedResult = Localization.AppleDisease.AppleScab.localized()
                    plantType = Localization.AppleDisease.Apple.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.AppleDisease.AppleScabAbout.localized()
                    treatmentTxt = Localization.AppleDisease.AppleScabTreatment.localized()
                    
                case "Apple___Black_rot":
                    predictedResult = Localization.AppleDisease.AppleBlackRot.localized()
                    plantType = Localization.AppleDisease.Apple.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.AppleDisease.AppleBlackRotAbout.localized()
                    treatmentTxt = Localization.AppleDisease.AppleBlackRotTreatment.localized()
                    
                case "Apple___Cedar_apple_rust":
                    predictedResult = Localization.AppleDisease.AppleCedar.localized()
                    plantType = Localization.AppleDisease.Apple.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.AppleDisease.AppleCedarAbout.localized()
                    treatmentTxt = Localization.AppleDisease.AppleCedarTreatment.localized()
                    
                case "Apple___healthy":
                    plantType = Localization.AppleDisease.Apple.localized()
                    predictedResult = Localization.Result.Healthy.localized()
                
                case "Blueberry___healthy":
                    plantType = Localization.Blueberry.Blueberry.localized()
                    predictedResult = Localization.Result.Healthy.localized()
                
                case "Cherry_(including_sour)___healthy":
                    plantType = Localization.Cherry.Cherry.localized()
                    predictedResult = Localization.Result.Healthy.localized()
                    
                case "Corn_(maize)___healthy":
                    plantType = Localization.CornDisease.Corn.localized()
                    predictedResult = Localization.Result.Healthy.localized()
                    
                case "Grape___healthy":
                    plantType = Localization.Grape.Grape.localized()
                    predictedResult = Localization.Result.Healthy.localized()
                    
                case "Peach___healthy":
                    plantType = Localization.Peach.Peach.localized()
                    predictedResult = Localization.Result.Healthy.localized()
                    
                case "Pepper,_bell___healthy":
                    plantType = Localization.PepperBell.PepperBell.localized()
                    predictedResult = Localization.Result.Healthy.localized()
                    
                case "Raspberry___healthy":
                    plantType = Localization.Raspberry.Raspberry.localized()
                    predictedResult = Localization.Result.Healthy.localized()
                    
                case "Soybean___healthy":
                    plantType = Localization.Soybean.Soybean.localized()
                    predictedResult = Localization.Result.Healthy.localized()
                    
                case "Strawberry___healthy":
                    plantType = Localization.Strawberry.Strawberry.localized()
                    predictedResult = Localization.Result.Healthy.localized()
                    
                case "Tomato___healthy":
                    plantType = Localization.Tomato.Tomato.localized()
                    predictedResult = Localization.Result.Healthy.localized()
                    
                case "Cherry_(including_sour)___Powdery_mildew":
                    predictedResult = Localization.Cherry.CherryPowderyMildew.localized()
                    plantType = Localization.Cherry.Cherry.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Cherry.CherryPowderyMildewAbout.localized()
                    treatmentTxt = Localization.Cherry.CherryPowderyMildewTreatment.localized()
                    
                case "Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot":
                    predictedResult = Localization.CornDisease.CornGraySpot.localized()
                    plantType = Localization.CornDisease.Corn.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.CornDisease.CornGraySpotAbout.localized()
                    treatmentTxt = Localization.CornDisease.CornGraySpotTreatment.localized()
                    
                case "Corn_(maize)___Common_rust_":
                    predictedResult = Localization.CornDisease.CornRust.localized()
                    plantType = Localization.CornDisease.Corn.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.CornDisease.CornRustAbout.localized()
                    treatmentTxt = Localization.CornDisease.CornRustTreatment.localized()
                    
                case "Corn_(maize)___Northern_Leaf_Blight":
                    predictedResult = Localization.CornDisease.CornNorthenBlight.localized()
                    plantType = Localization.CornDisease.Corn.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.CornDisease.CornNorthenBlightAbout.localized()
                    treatmentTxt = Localization.CornDisease.CornNorthenBlightTreatment.localized()
                    
                case "Grape___Black_rot":
                    predictedResult = Localization.Grape.BlackRot.BlackRot.localized()
                    plantType = Localization.Grape.Grape.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Grape.BlackRot.BlackRotAbout.localized()
                    treatmentTxt = Localization.Grape.BlackRot.BlackRotTreatment.localized()
                    
                case "Grape___Esca_(Black_Measles)":
                    predictedResult = Localization.Grape.Esca.Esca.localized()
                    plantType = Localization.Grape.Grape.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Grape.Esca.EscaAbout.localized()
                    treatmentTxt = Localization.Grape.Esca.EscaTreatment.localized()
                    
                case "Grape___Leaf_blight_(Isariopsis_Leaf_Spot)":
                    predictedResult = Localization.Grape.GrapeLeafBlight.GrapeLeafBlight.localized()
                    plantType = Localization.Grape.Grape.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Grape.GrapeLeafBlight.GrapeLeafBlightAbout.localized()
                    treatmentTxt = Localization.Grape.GrapeLeafBlight.GrapeLeafBlightTreatment.localized()
                    
                case "Orange___Haunglongbing_(Citrus_greening)":
                    predictedResult = Localization.Orange.OrangeHaunglongbing.localized()
                    plantType = Localization.Orange.Orange.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Orange.OrangeHaunglongbingAbout.localized()
                    treatmentTxt = Localization.Orange.OrangeHaunglongbingTreatment.localized()
                    
                case "Peach___Bacterial_spot":
                    predictedResult = Localization.Peach.PeachBacterialSpot.localized()
                    plantType = Localization.Peach.Peach.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Peach.PeachBacterialSpotAbout.localized()
                    treatmentTxt = Localization.Peach.PeachBacterialSpotTreatment.localized()
                    
                case "Pepper,_bell___Bacterial_spot":
                    predictedResult = Localization.PepperBell.BacterialSpot.BacterialSpot.localized()
                    plantType = Localization.PepperBell.PepperBell.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.PepperBell.BacterialSpot.BacterialSpotAbout.localized()
                    treatmentTxt = Localization.PepperBell.BacterialSpot.BacterialSpotTreatment.localized()
                    
                case "Potato___Early_blight":
                    predictedResult = Localization.Potato.EarlyBlight.EarlyBlight.localized()
                    plantType = Localization.Potato.Potato.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Potato.EarlyBlight.EarlyBlightAbout.localized()
                    treatmentTxt = Localization.Potato.EarlyBlight.EarlyBlightTreatment.localized()
                    
                case "Potato___Late_blight":
                    predictedResult = Localization.Potato.LateBlight.LateBlight.localized()
                    plantType = Localization.Potato.Potato.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Potato.LateBlight.LateBlightAbout.localized()
                    treatmentTxt = Localization.Potato.LateBlight.LateBlightTreatment.localized()
                    
                case "Squash___Powdery_mildew":
                    predictedResult = Localization.Squash.SquashPowderyMildew.localized()
                    plantType = Localization.Squash.Squash.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Squash.SquashPowderyMildewAbout.localized()
                    treatmentTxt = Localization.Squash.SquashPowderyMildewTreatment.localized()
                    
                case "Strawberry___Leaf_scorch":
                    predictedResult = Localization.Strawberry.StrawberryLeafScorch.localized()
                    plantType = Localization.Strawberry.Strawberry.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Strawberry.StrawberryLeafScorchAbout.localized()
                    treatmentTxt = Localization.Strawberry.StrawberryLeafScorchTreatment.localized()
                    
                case "Tomato___Bacterial_spot":
                    predictedResult = Localization.Tomato.TomatoBacterialSpot.TomatoBacterialSpot.localized()
                    plantType = Localization.Tomato.Tomato.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Tomato.TomatoBacterialSpot.TomatoBacterialSpotAbout.localized()
                    treatmentTxt = Localization.Tomato.TomatoBacterialSpot.TomatoBacterialSpotTreatment.localized()
                    
                case "Tomato___Early_blight":
                    predictedResult = Localization.Tomato.TomatoEarlyBlight.TomatoEarlyBlight.localized()
                    plantType = Localization.Tomato.Tomato.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Tomato.TomatoEarlyBlight.TomatoEarlyBlighAbout.localized()
                    treatmentTxt = Localization.Tomato.TomatoEarlyBlight.TomatoEarlyBlighTreatment.localized()
                    
                case "Tomato___Late_blight":
                    predictedResult = Localization.Tomato.TomatoLateBlight.TomatoLateBlight.localized()
                    plantType = Localization.Tomato.Tomato.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Tomato.TomatoLateBlight.TomatoLateBlightAbout.localized()
                    treatmentTxt = Localization.Tomato.TomatoLateBlight.TomatoLateBlightTreatment.localized()
                    
                case "Tomato___Leaf_Mold":
                    predictedResult = Localization.Tomato.TomatoLeafMold.TomatoLeafMold.localized()
                    plantType = Localization.Tomato.Tomato.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Tomato.TomatoLeafMold.TomatoLeafMoldAbout.localized()
                    treatmentTxt = Localization.Tomato.TomatoLeafMold.TomatoLeafMoldTreatment.localized()
                    
                case "Tomato___Septoria_leaf_spot":
                    predictedResult = Localization.Tomato.TomatoSeptoriaLeafSpot.TomatoSeptoriaLeafSpot.localized()
                    plantType = Localization.Tomato.Tomato.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Tomato.TomatoSeptoriaLeafSpot.TomatoSeptoriaLeafSpotAbout.localized()
                    treatmentTxt = Localization.Tomato.TomatoSeptoriaLeafSpot.TomatoSeptoriaLeafSpotTreatment.localized()
                    
                case "Tomato___Spider_mites Two-spotted_spider_mite":
                    predictedResult = Localization.Tomato.TomatoSpiderMites.TomatoSpiderMites.localized()
                    plantType = Localization.Tomato.Tomato.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Tomato.TomatoSpiderMites.TomatoSpiderMitesAbout.localized()
                    treatmentTxt = Localization.Tomato.TomatoSpiderMites.TomatoSpiderMitesTreatment.localized()
                    
                case "Tomato___Target_Spot":
                    predictedResult = Localization.Tomato.TomatoTargetSpot.TomatoTargetSpot.localized()
                    plantType = Localization.Tomato.Tomato.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Tomato.TomatoTargetSpot.TomatoTargetSpotAbout.localized()
                    treatmentTxt = Localization.Tomato.TomatoTargetSpot.TomatoTargetSpotTreatment.localized()
                    
                case "Tomato___Tomato_Yellow_Leaf_Curl_Virus":
                    predictedResult = Localization.Tomato.TomatoYellowLeafCurlVirus.TomatoYellowLeafCurlVirus.localized()
                    plantType = Localization.Tomato.Tomato.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Tomato.TomatoYellowLeafCurlVirus.TomatoYellowLeafCurlVirusAbout.localized()
                    treatmentTxt = Localization.Tomato.TomatoYellowLeafCurlVirus.TomatoYellowLeafCurlVirusTreatment.localized()
                    
                case "Tomato___Tomato_mosaic_virus":
                    predictedResult = Localization.Tomato.TomatoMosaicVirus.TomatoMosaicVirus.localized()
                    plantType = Localization.Tomato.Tomato.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.MediumLevel.localized()
                    aboutTxt = Localization.Tomato.TomatoMosaicVirus.TomatoMosaicVirusAbout.localized()
                    treatmentTxt = Localization.Tomato.TomatoMosaicVirus.TomatoMosaicVirusTreatment.localized()
                    
                default:
                    predictedResult = Localization.Result.NoResult.localized()
                }
               
                // Update the main UI thread with our result
                DispatchQueue.main.async { [weak self] in
                    let vc = UIStoryboard(name: NameConstant.Storyboard.Home,
                                          bundle: nil).instantiateVC(ClassifyResultVC.self)
                    vc.model = DiseaseInfoViewEntity.Disease(diseaseImage: pickedImage,
                                                             diseaseName: predictedResult,
                                                             plantName: plantType,
                                                             typeDisease: type,
                                                             threatLevel: threatLevel,
                                                             symptomInfo: aboutTxt,
                                                             treatmentInfo: treatmentTxt,
                                                             certainty: predconfidence)
                    self?.navigationController?.pushViewController(vc, animated: true)
                    vc.hidesBottomBarWhenPushed = true
                }
            }
            
            guard let ciImage = CIImage(image: pickedImage)
                else { fatalError("Cannot read picked image")}
            
            // Run the classifier
            let handler = VNImageRequestHandler(ciImage: ciImage)
            DispatchQueue.global().async {
                do {
                    try handler.perform([request])
                } catch {
                    print(error)
                }
            }
        } else {
            ProgressHUD.showError(Localization.Notification.Error.localized())
        }
    }
    
}

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return blogs.array.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlogCell", for: indexPath) as? BlogCell else {
            fatalError()
        }
        let item = blogs.array[indexPath.item]
        cell.config(with: item)
        return cell
    }
}
extension HomeVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: NameConstant.Storyboard.Home,
                                    bundle: nil).instantiateVC(DetailDiseaseVC.self)
        let item = blogs.array[indexPath.item]
        vc.model = item
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        self.collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width,
               height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
