import UIKit

class DiseaseCell: UITableViewCell {
    
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var img: UIImageView!
    @IBOutlet private weak var diseaseName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    private func setupUI() {
        cellView.layer.cornerRadius = 10
        cellView.layer.borderWidth = 1.5
        cellView.layer.borderColor = AppColor.LightGrayColor2?.cgColor
        cellView.clipsToBounds = true
        
        cellView.layer.shadowColor = AppColor.BlackColor?.cgColor
        cellView.layer.shadowOpacity = 0.3
        cellView.layer.shadowOffset = CGSize(width: 0, height: 5)
    }

    func configDiseaseCell(with model: DiseaseInfoViewEntity.Disease) {
        img.image = model.diseaseImage
        diseaseName.text = model.diseaseName.localized()
    }

}
