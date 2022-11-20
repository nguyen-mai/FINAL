import Foundation
import UIKit

struct OnboardingViewEntity {
    struct OnboardingModel {
        let title: String?
        let description: String?
        let image: UIImage?
    }
    
    let array: [OnboardingModel] = [
        OnboardingModel(title: Localization.Onboarding.titleSlide1.localized(),
                        description: Localization.Onboarding.descriptionSlide1.localized(),
                        image: UIImage(named: AppImage.Image.Slide1.localized())),
        OnboardingModel(title: Localization.Onboarding.titleSlide2.localized(),
                        description: Localization.Onboarding.descriptionSlide2.localized(),
                        image: UIImage(named: AppImage.Image.Slide2.localized())),
        OnboardingModel(title: Localization.Onboarding.titleSlide3.localized(),
                        description: Localization.Onboarding.descriptionSlide3.localized(),
                        image: UIImage(named: AppImage.Image.Slide3))
    ]
}
