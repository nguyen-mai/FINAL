import Foundation

final class AppPreferences {
    static let shared: AppPreferences = AppPreferences()
    var language: EnumConstant.Language = .vietnamese
    
    func getLanguage() {
        if let languageValue = UserDefaults.standard.string(forKey: NameConstant.UserDefaults.Language) {
            language = EnumConstant.Language(rawValue: languageValue) ?? .english
        } else {
            language = EnumConstant.Language(rawValue: Locale.current.languageCode ?? "") ?? .english
        }
    }
    
    func setLanguage(_ value: EnumConstant.Language) {
        UserDefaults.standard.set(value.rawValue, forKey: NameConstant.UserDefaults.Language)
        language = value
    }
}
