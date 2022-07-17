import Foundation

struct SettingViewEntity {
    struct Setting {
        let image: String
        let title: String
    }
    
    let array: [Setting] = [
        Setting(image: AppImage.Icon.Language, title: Localization.Setting.Language),
        Setting(image: AppImage.Icon.History, title: Localization.Setting.History)
    ]
}
