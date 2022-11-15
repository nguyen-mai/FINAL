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
        searchTextField.addTarget(self, action: #selector(searchTextFieldTap), for: .editingDidBegin)
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
        cameraBtn.setTitle(Localization.Home.TakePicture, for: .normal)
        cameraBtn.setTitleColor(AppColor.WhiteColor, for: .normal)
        cameraBtn.addTarget(self, action: #selector(cameraBtnTap), for: .touchUpInside)
        
        allButton.setTitle(Localization.Home.All, for: .normal)
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
                var conditionTxt: String = Localization.Result.None.localized()
                var treatmentTxt: String = Localization.Result.None.localized()
                switch predictedResult {
                case "Apple___Apple_scab":
                    predictedResult = Localization.AppleDisease.AppleScab.localized()
                    plantType = Localization.AppleDisease.Apple.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    aboutTxt = Localization.AppleDisease.AppleScabAbout.localized()
                    conditionTxt = Localization.AppleDisease.AppleScabCondition.localized()
                    treatmentTxt = Localization.AppleDisease.AppleScabTreatment.localized()
                    
                case "Apple___Black_rot":
                    predictedResult = Localization.AppleDisease.AppleBlackRot.localized()
                    plantType = Localization.AppleDisease.Apple.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    aboutTxt = Localization.AppleDisease.AppleBlackRotAbout.localized()
                    conditionTxt = Localization.AppleDisease.AppleBlackRotCondition.localized()
                    treatmentTxt = Localization.AppleDisease.AppleBlackRotTreatment.localized()
                    
                case "Apple___Cedar_apple_rust":
                    predictedResult = Localization.AppleDisease.AppleCedar.localized()
                    plantType = Localization.AppleDisease.Apple.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    aboutTxt = Localization.AppleDisease.AppleCedarAbout.localized()
                    conditionTxt = Localization.AppleDisease.AppleCedarCondition.localized()
                    treatmentTxt = Localization.AppleDisease.AppleCedarTreatment.localized()
                    
                case "Apple___healthy", "Blueberry___healthy", "Cherry_(including_sour)___healthy", "Corn_(maize)___healthy", "Grape___healthy", "Peach___healthy", "Pepper,_bell___healthy", "Potato___healthy", "Raspberry___healthy", "Soybean___healthy", "Strawberry___healthy", "Tomato___healthy":
                    predictedResult = Localization.Result.Healthy.localized()
                    
                case "Cherry_(including_sour)___Powdery_mildew":
                    predictedResult = "Cherry Powdery Mildew".localized()
                    plantType = "Cherry"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot":
                    predictedResult = Localization.CornDisease.CornGraySpot.localized()
                    plantType = Localization.CornDisease.Corn.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    aboutTxt = Localization.CornDisease.CornGraySpotAbout.localized()
                    conditionTxt = Localization.CornDisease.CornGraySpotCondition.localized()
                    treatmentTxt = Localization.CornDisease.CornGraySpotTreatment.localized()
                    
                case "Corn_(maize)___Common_rust_":
                    predictedResult = Localization.CornDisease.CornRust.localized()
                    plantType = Localization.CornDisease.Corn.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    aboutTxt = Localization.CornDisease.CornRustAbout.localized()
                    conditionTxt = Localization.CornDisease.CornRustCondition.localized()
                    treatmentTxt = Localization.CornDisease.CornRustTreatment.localized()
                    
                case "Corn_(maize)___Northern_Leaf_Blight":
                    predictedResult = Localization.CornDisease.CornNorthenBlight.localized()
                    plantType = Localization.CornDisease.Corn.localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    aboutTxt = Localization.CornDisease.CornNorthenBlightAbout.localized()
                    conditionTxt = Localization.CornDisease.CornNorthenBlightCondition.localized()
                    treatmentTxt = Localization.CornDisease.CornNorthenBlightTreatment.localized()
                    
                case "Grape___Black_rot":
                    predictedResult = "Black Rot".localized()
                    plantType = "Grape".localized()
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Grape___Esca_(Black_Measles)":
                    predictedResult = "Grape Esca"
                    plantType = "Grape"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Grape___Leaf_blight_(Isariopsis_Leaf_Spot)":
                    predictedResult = "Grape Leaf Blight"
                    plantType = "Grape"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.Fungus.localized()
                    
                case "Orange___Haunglongbing_(Citrus_greening)":
                    predictedResult = "Orange Haunglongbing"
                    plantType = "Orange"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Peach___Bacterial_spot":
                    predictedResult = "Peach Bacterial Spot"
                    plantType = "Peach"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Pepper,_bell___Bacterial_spot":
                    predictedResult = "Bacterial Spot"
                    plantType = "Pepper Bell"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Potato___Early_blight":
                    predictedResult = "Early Blight"
                    plantType = "Potato"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Potato___Late_blight":
                    predictedResult = "Potato Late Blight"
                    plantType = "Potato"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Squash___Powdery_mildew":
                    predictedResult = "Squash Powdery Mildew"
                    plantType = "Squash"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Strawberry___Leaf_scorch":
                    predictedResult = "Strawberry Leaf Scorch"
                    plantType = "Strawberry"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Tomato___Bacterial_spot":
                    predictedResult = "Tomato Bacterial Spot"
                    plantType = "Tomato"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Tomato___Early_blight":
                    predictedResult = "Tomato Early Blight"
                    plantType = "Tomato"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Tomato___Late_blight":
                    predictedResult = "Tomato Late Blight"
                    plantType = "Tomato"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Tomato___Leaf_Mold":
                    predictedResult = "Tomato Leaf Mold"
                    plantType = "Tomato"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Tomato___Septoria_leaf_spot":
                    predictedResult = "Tomato Septoria Leaf Spot"
                    plantType = "Tomato"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Tomato___Spider_mites Two-spotted_spider_mite":
                    predictedResult = "Tomato Spider Mites"
                    plantType = "Tomato"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Tomato___Target_Spot":
                    predictedResult = "Tomato Target Spot"
                    plantType = "Tomato"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Tomato___Tomato_Yellow_Leaf_Curl_Virus":
                    predictedResult = "Tomato Yellow Leaf Curl Virus"
                    plantType = "Tomato"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
                case "Tomato___Tomato_mosaic_virus":
                    predictedResult = "Tomato Mosaic Virus"
                    plantType = "Tomato"
                    type = Localization.Result.Fungus.localized()
                    threatLevel = Localization.Result.HighLevel.localized()
                    
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
                                                             conditionInfo: conditionTxt,
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
