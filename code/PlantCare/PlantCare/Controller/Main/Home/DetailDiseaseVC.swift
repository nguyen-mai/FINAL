import UIKit

class DetailDiseaseVC: UIViewController {
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var typeText: UILabel!
    @IBOutlet private weak var threatText: UILabel!
    @IBOutlet private weak var conditionText: UILabel!
    @IBOutlet private weak var aboutText: UILabel!
    @IBOutlet private weak var typeDiseasesText: UILabel!
    @IBOutlet private weak var treatmentText: UILabel!
    
    @IBOutlet private weak var aboutTitle: UIButton!
    @IBOutlet private weak var conditionTitle: UIButton!
    @IBOutlet private weak var treatmentTitle: UIButton!
   
    // MARK: - Variables
    var img = ""
    var lbl = ""
    private var type = ""
    private var threat = ""
    private var typeDisease = ""
    private var about = ""
    private var condition = ""
    private var treatment = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = AppColor.GreenColor
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setupUI() {
        setupImageView()
        setupLabel()
        setupButton()
    }
    
    private func setupImageView() {
        image.image = UIImage(named: img)
        image.layer.cornerRadius = 20
    }
    
    private func setupLabel() {
        switch lbl {
        case "Apple Scab":
            type = Localization.AppleDisease.Apple
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            about = Localization.AppleDisease.AppleScabAbout
            condition = Localization.AppleDisease.AppleScabCondition
            treatment = Localization.AppleDisease.AppleScabTreatment
            
        case "Apple Black Rot":
            type = Localization.AppleDisease.Apple
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            about = Localization.AppleDisease.AppleBlackRotAbout
            condition = Localization.AppleDisease.AppleBlackRotCondition
            treatment = Localization.AppleDisease.AppleBlackRotTreatment
            
        case "Apple Cedar Rust":
            type = Localization.AppleDisease.Apple
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            about = Localization.AppleDisease.AppleCedarAbout
            condition = Localization.AppleDisease.AppleCedarCondition
            treatment = Localization.AppleDisease.AppleCedarTreatment
            
        case "Cherry Powdery Mildew":
            type = "Cherry"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
        
        case "Corn Gray Leaf Spot":
            type = Localization.CornDisease.CornGraySpot
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            about = Localization.CornDisease.CornGraySpotAbout
            condition = Localization.CornDisease.CornRustCondition
            treatment = Localization.CornDisease.CornRustTreatment
            
        case "Corn Cercospora Leaf Spot Gray Leaf Spot":
            type = Localization.CornDisease.Corn
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            about = Localization.CornDisease.CornGraySpotAbout
            condition = Localization.CornDisease.CornGraySpotCondition
            treatment = Localization.CornDisease.CornGraySpotTreatment
            
        case "Corn Common Rust":
            type = Localization.CornDisease.Corn
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            about = Localization.CornDisease.CornRustAbout
            condition = Localization.CornDisease.CornRustCondition
            treatment = Localization.CornDisease.CornRustTreatment
            
        case "Corn Northern Leaf Blight":
            type = Localization.CornDisease.Corn
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            about = Localization.CornDisease.CornNorthenBlightAbout
            condition = Localization.CornDisease.CornNorthenBlightCondition
            treatment = Localization.CornDisease.CornNorthenBlightTreatment
            
        case "Grape Black Rot":
            type = "Grape"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        case "Grape Esca":
            type = "Grape"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        case "Grape Leaf Blight":
            type = "Grape"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        case "OrangeHaunglongbing":
            type = "Orange"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        case "Peach Bacterial Spot":
            type = "Peach"
            typeDisease = "Fungus"
            threat = Localization.Result.HighLevel
            
        case "Pepper Bell Bacterial Spot":
            type = "Pepper bell"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        case "Potato Early Blight":
            type = "Potato"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        case "Potato Late Blight":
            type = "Potato"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        case "Squash Powdery Mildew":
            type = "Squash"
            typeDisease = "Fungus"
            threat = Localization.Result.HighLevel
            
        case "Strawberry Leaf Scorch":
            type = "Strawberry"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        case "Tomato Bacterial Spot":
            type = "Tomato"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        case "Tomato Early Blight":
            type = "Tomato"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        case "Tomato Late Blight":
            type = "Tomato"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        case "Tomato Leaf Mold":
            type = "Tomato"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        case "Tomato Septoria leaf Spot":
            type = "Tomato"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        case "Tomato Spider Mites":
            type = "Tomato"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        case "Tomato Target Spot":
            type = "Tomato"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        case "Tomato Tomato Yellow Leaf Curl Virus":
            type = "Tomato"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        case "Tomato Mosaic Virus":
            type = "Tomato"
            typeDisease = Localization.Result.Fungus
            threat = Localization.Result.HighLevel
            
        default:
            aboutText.text = Localization.Result.None
            conditionText.text = Localization.Result.None
            treatmentText.text = Localization.Result.None
        }
        
        name.text = lbl.localized()
        print("LABEL: \(lbl)")
        typeText.text = type.localized()
        print("TYPE: \(type)")
        typeDiseasesText.text = Localization.Result.TypeTitle.localized() + ": \(typeDisease.localized())"
        threatText.text = Localization.Result.ThreatTitle.localized() + ": \(threat.localized())"
        aboutText.text = about.localized()
        conditionText.text = condition.localized()
        treatmentText.text = treatment.localized()
    }
    
    private func setupButton() {
        aboutTitle.setTitle(Localization.Result.SymptomTitle.localized().uppercased(), for: .normal)
        conditionTitle.setTitle(Localization.Result.ConditionTitle.localized().uppercased(), for: .normal)
        treatmentTitle.setTitle(Localization.Result.PreventionTitle.localized().uppercased(), for: .normal)
    }
}
