import UIKit

class ClassifyResultVC: UIViewController {
    @IBOutlet private weak var result: UILabel!
    @IBOutlet private weak var plant: UILabel!
    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var certainty: UILabel!
    @IBOutlet private weak var type: UILabel!
    @IBOutlet private weak var threatLevel: UILabel!
    
    @IBOutlet private weak var aboutBtn: UIButton!
    @IBOutlet private weak var conditionBtn: UIButton!
    @IBOutlet private weak var treatmentBtn: UIButton!
    
    @IBOutlet private weak var about: UILabel!
    @IBOutlet private weak var condition: UILabel!
    @IBOutlet private weak var treatment: UILabel!
    
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    var image = UIImage()
    var plantTypeText: String = ""
    var resultText: String = ""
    var certaintyText: String = ""
    var typeText: String = ""
    var threatLevelText: String = ""
    var aboutText: String = ""
    var conditionText: String = ""
    var treatmentText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
                
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupUI() {
        setupButton()
        setupLabel()
        setupImageView()
    }
  
    private func setupButton() {
        // Tittle Button
        aboutBtn.setTitle(Localization.Result.SymptomTitle.localized().uppercased(), for: .normal)
        conditionBtn.setTitle(Localization.Result.ConditionTitle.localized().uppercased(), for: .normal)
        treatmentBtn.setTitle(Localization.Result.PredictionTitle.localized().uppercased(), for: .normal)
        
        yesButton.setTitle(Localization.Alert.Yes.localized(), for: .normal)
        yesButton.addTarget(self, action: #selector(yesBtnTap), for: .touchUpInside)
        
        noButton.setTitle(Localization.Alert.No.localized(), for: .normal)
        noButton.addTarget(self, action: #selector(noBtnTap), for: .touchUpInside)
    }
    
    private func setupLabel() {
        result.text = resultText
        plant.text = plantTypeText
        certainty.text = Localization.Result.CertaintyTitle.localized() + ": \(certaintyText) %"
        type.text = Localization.Result.TypeTitle.localized() + ": \(typeText)"
        threatLevel.text = Localization.Result.ThreatTitle.localized() + ": \(threatLevelText)"
        about.text = aboutText
        condition.text = conditionText
        treatment.text = treatmentText
        
        infoLabel.text = Localization.Alert.AuthentInfo.localized()
    }
    
    private func setupImageView() {
        img.image = image
        img.layer.cornerRadius = 20
    }
}

// MARK: - Handle actions
extension ClassifyResultVC {

    @IBAction private func aboutTap(_ sender: Any) {
    }
    
    @IBAction private func conditionTap(_ sender: Any) {
    }
    
    
    @IBAction private func treatementTap(_ sender: Any) {
    }
    
    @IBAction func noBtnTapped(_ sender: Any) {
        let ac = UIAlertController(title: "Label again", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
    
    @objc private func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func noBtnTap() {
        
    }
    
    @objc private func yesBtnTap() {
        
    }
}
