import Foundation

extension String {
    func localized(comment: String = "") -> String {

        guard let path = Bundle.main.path(forResource: AppPreferences.shared.language.rawValue, ofType: "lproj") else {
            return ""
        }
        
        guard let bundle = Bundle(path: path) else {
            return ""
        }
        
        return bundle.localizedString(forKey: self, value: "", table: nil)
    }
}
