import UIKit

class HeaderReferenceCell: UITableViewCell {
    @IBOutlet private weak var diseaseNameLabel: UILabel!
    @IBOutlet private weak var plantNameLabel: UILabel!
    @IBOutlet private weak var typeDiseaseLabel: UILabel!
    @IBOutlet private weak var diseaseImageView: CustomImageView!
    @IBOutlet private weak var threatDiseaseLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        diseaseImageView.layer.cornerRadius = 10
    }

    func configHeaderDiseaseInfoCell(content: DiseaseInfoViewEntity.Disease, urlImage: String = "") {
        diseaseNameLabel.text = content.diseaseName.localized()
        plantNameLabel.text = content.plantName.localized()
        
        typeDiseaseLabel.text = Localization.Result.TypeTitle.localized() + ": " + content.typeDisease.localized()
        threatDiseaseLevelLabel.text = Localization.Result.ThreatTitle.localized() + ": " + content.threatLevel.localized()
        if urlImage.isEmpty {
            diseaseImageView.image = content.diseaseImage
        } else {
            diseaseImageView.loadImage(urlString: urlImage)
        }
    }
}
