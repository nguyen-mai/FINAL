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
        dimView.layer.cornerRadius = 20
        img.layer.cornerRadius = 20
    }
    
    func config(with model: BlogViewEntity.Blog) {
        guard let urlImg = model.urlImg else {
            return
        }
        img.image = UIImage(named: urlImg)
        title.text = model.diseaseName.localized()
    }
    
}
