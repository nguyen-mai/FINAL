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
        cellView.layer.cornerRadius = 20
        
        img.layer.cornerRadius = 10
    }

    func configDiseaseCell(with model: BlogViewEntity.Blog) {
        guard let urlImg = model.urlImg else {
            return
        }
        img.image = UIImage(named: urlImg)
        diseaseName.text = model.diseaseName.localized()
    }

}
