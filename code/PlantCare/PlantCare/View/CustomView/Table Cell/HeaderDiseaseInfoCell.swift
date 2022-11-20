import UIKit

class HeaderDiseaseInfoCell: UITableViewCell {
    @IBOutlet private weak var diseaseNameLabel: UILabel!
    @IBOutlet private weak var plantNameLabel: UILabel!
    @IBOutlet private weak var diseaseImageView: UIImageView!
    @IBOutlet private weak var certaintyDiseaseLabel: UILabel!
    @IBOutlet private weak var typeDiseaseLabel: UILabel!
    @IBOutlet private weak var threatDiseaseLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        diseaseImageView.layer.cornerRadius = 10
    }

    func configHeaderDiseaseInfoCell(content: DiseaseInfoViewEntity.Disease) {
        diseaseNameLabel.text = content.diseaseName.localized()
        plantNameLabel.text = content.plantName.localized()
        diseaseImageView.image = content.diseaseImage
        let certaintyString = String(format: "%.02f%", content.certainty * 100)
        certaintyDiseaseLabel.text = Localization.Result.CertaintyTitle.localized() + ": " + certaintyString + "%"
        typeDiseaseLabel.text = Localization.Result.TypeTitle.localized() + ": " + content.typeDisease.localized()
        threatDiseaseLevelLabel.text = Localization.Result.ThreatTitle.localized() + ": " + content.threatLevel.localized()
    }
}
