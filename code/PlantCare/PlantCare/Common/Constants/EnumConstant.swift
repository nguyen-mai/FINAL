import Foundation

struct EnumConstant {
    enum Language: String, CaseIterable {
        case vietnamese = "vi"
        case english = "en"
        
        var title: String {
            switch self {
            case .vietnamese:
                return Localization.Language.Vietnamese
            case .english:
                return Localization.Language.English
            }
        }
    }
    
    enum Picker {
        case camera
        case photo
    }
    
    // MARK: - Set up onboarding status
    enum OnboardingStatus: Int, CaseIterable {
        case Onboard = 0
        case LoggedIn = 1
        case Home = 2
    }
}
