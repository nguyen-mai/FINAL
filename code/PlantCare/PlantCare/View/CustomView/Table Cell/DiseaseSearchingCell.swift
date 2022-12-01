import UIKit

class DiseaseSearchingCell: UITableViewCell {
    
    @IBOutlet private weak var img: CustomImageView!
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var diseaseName: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
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
    
    func configDiseaseSearchingCell(with model: ClassifyingResult) {
        img.loadImage(urlString: model.imageUrl)
        diseaseName.text = model.diseaseName.localized()
//        timeLabel.text = model.creationDate.timeAgoDisplay()
        timeLabel.text = model.creationDate.timeDayDisplay().localized()
    }
}

