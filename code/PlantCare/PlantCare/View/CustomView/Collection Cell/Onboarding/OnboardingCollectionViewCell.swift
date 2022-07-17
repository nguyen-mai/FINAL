import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var slideImageView: UIImageView!
    
    @IBOutlet private weak var slideTitleLbl: UILabel!
    
    @IBOutlet private weak var slideDescriptionLbl: UILabel!
    
    func config(_ slide: OnboardingViewEntity.OnboardingModel) {
        slideImageView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }
    
}

