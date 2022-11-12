import UIKit

class BlogCell: UICollectionViewCell {
    @IBOutlet private weak var img: UIImageView!
    
    @IBOutlet private weak var title: UILabel!
    
    @IBOutlet private weak var dimView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    private func setupUI() {
        dimView.layer.cornerRadius = 10
        img.layer.cornerRadius = 10
        
        dimView.clipsToBounds = true
        img.clipsToBounds = true
    }
    
    func config(with model: DiseaseInfoViewEntity.Disease) {
        img.image = model.diseaseImage
        title.text = model.diseaseName.localized()
    }
    
}
