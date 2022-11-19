import Foundation

struct SettingViewEntity {
    struct Setting {
        let image: String
        let title: String
    }
    
    let loginedArray: [Setting] = [
        Setting(image: AppImage.Icon.Language, title: Localization.Setting.Language),
        Setting(image: AppImage.Icon.History, title: Localization.Setting.PostingHistory),
        Setting(image: AppImage.Icon.Search, title: Localization.Setting.SearchingHistory),
        Setting(image: AppImage.Icon.EditProfile, title: Localization.Setting.EditingInfo)
    ]
    let notLoginArray: [Setting] = [
        Setting(image: AppImage.Icon.Language, title: Localization.Setting.Language)
    ]
}
