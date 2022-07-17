import Foundation
import UIKit

struct OnboardingViewEntity {
    struct OnboardingModel {
        let title: String?
        let description: String?
        let image: UIImage?
    }
    
    let array: [OnboardingModel] = [
        OnboardingModel(title: Localization.Onboarding.titleSlide1,
                        description: Localization.Onboarding.descriptionSlide1,
                        image: UIImage(named: AppImage.Image.Slide1)),
        OnboardingModel(title: Localization.Onboarding.titleSlide2,
                        description: Localization.Onboarding.descriptionSlide2,
                        image: UIImage(named: AppImage.Image.Slide2)),
        OnboardingModel(title: Localization.Onboarding.titleSlide3,
                        description: Localization.Onboarding.descriptionSlide3,
                        image: UIImage(named: AppImage.Image.Slide3))
    ]
}
