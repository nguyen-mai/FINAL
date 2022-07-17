import Foundation

struct LanguageViewEntity {
    struct Country {
        let id: EnumConstant.Language
        let name: String
    }
    
    let listCountry: [LanguageViewEntity.Country] = [
        LanguageViewEntity.Country(id: .vietnamese, name: Localization.Language.Vietnamese.localized()),
        LanguageViewEntity.Country(id: .english, name: Localization.Language.English.localized())
    ]
}
