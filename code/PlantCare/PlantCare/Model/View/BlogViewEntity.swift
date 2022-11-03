import Foundation

struct BlogViewEntity {
    struct Blog {
        let urlImg: String?
        let diseaseName: String
    }
    
    let array: [Blog] = [
        Blog(urlImg: AppImage.DiseaseImage.CornGrayLeafSpot,
             diseaseName: Localization.CornDisease.CornGraySpot.localized()),
        Blog(urlImg: AppImage.DiseaseImage.AppleScab,
             diseaseName: Localization.AppleDisease.AppleScab.localized()),
        Blog(urlImg: AppImage.DiseaseImage.TomatoBacterialSpot,
             diseaseName: Localization.CornDisease.CornRust.localized()),
        Blog(urlImg: AppImage.DiseaseImage.TomatoBacterialSpot,
             diseaseName: Localization.CornDisease.CornNorthenBlight.localized()),
        Blog(urlImg: AppImage.DiseaseImage.TomatoBacterialSpot,
             diseaseName: Localization.CornDisease.CornNorthenBlight.localized()),
        Blog(urlImg: AppImage.DiseaseImage.TomatoBacterialSpot,
             diseaseName: Localization.CornDisease.CornNorthenBlight.localized()),
        Blog(urlImg: AppImage.DiseaseImage.TomatoBacterialSpot,
             diseaseName: Localization.CornDisease.CornNorthenBlight.localized())
    ]
}
