//
//  DiseaseInfoViewEntity.swift
//  PlantCare
//
//  Created by Mai on 2022/11/7.
//

import Foundation
import UIKit

struct DiseaseInfoViewEntity {
    struct Disease {
        var diseaseImage: UIImage
        var diseaseName: String
        var plantName: String
        var typeDisease: String
        var threatLevel: String
        var symptomInfo: String
        var conditionInfo: String
        var treatmentInfo: String
        var certainty: Double
        
        init(diseaseImage: UIImage = UIImage(named: AppImage.Icon.PlaceholderPhoto) ?? UIImage(named: AppImage.Icon.PlaceholderPhoto)!,
             diseaseName: String = "",
             plantName: String = "",
             typeDisease: String = "",
             threatLevel: String = "",
             symptomInfo: String = "",
             conditionInfo: String = "",
             treatmentInfo: String = "",
             certainty: Double = 0) {
            self.diseaseImage = diseaseImage
            self.diseaseName = diseaseName
            self.plantName = plantName
            self.typeDisease = typeDisease
            self.threatLevel = threatLevel
            self.symptomInfo = symptomInfo
            self.conditionInfo = conditionInfo
            self.treatmentInfo = treatmentInfo
            self.certainty = certainty
        }
   }
    
    struct ExpandedCell {
        var title: String
        var detail: String
        
        init(title: String, detail: String) {
            self.title = title
            self.detail = detail
        }
    }
    
    let array: [Disease] = [
        Disease(diseaseImage: UIImage(named: AppImage.DiseaseImage.CornGrayLeafSpot) ?? UIImage(named: AppImage.Icon.PlaceholderPhoto)!,
                diseaseName: Localization.CornDisease.CornGraySpot.localized(),
                plantName: Localization.CornDisease.Corn.localized(),
                typeDisease: Localization.Result.Fungus.localized(),
                threatLevel: Localization.Result.HighLevel.localized(),
                symptomInfo: Localization.CornDisease.CornGraySpotAbout.localized(),
                conditionInfo: Localization.CornDisease.CornGraySpotCondition.localized(),
                treatmentInfo: Localization.CornDisease.CornGraySpotTreatment.localized(),
                certainty: 0),
    Disease(diseaseImage: UIImage(named: AppImage.DiseaseImage.AppleScab) ?? UIImage(named: AppImage.Icon.PlaceholderPhoto)!,
            diseaseName: Localization.AppleDisease.AppleScab.localized(),
            plantName: Localization.AppleDisease.Apple.localized(),
            typeDisease: Localization.Result.Fungus.localized(),
            threatLevel: Localization.Result.HighLevel.localized(),
            symptomInfo: Localization.AppleDisease.AppleScabAbout.localized(),
            conditionInfo: Localization.AppleDisease.AppleScabCondition.localized(),
            treatmentInfo: Localization.AppleDisease.AppleScabTreatment.localized(),
            certainty: 0),
    Disease(diseaseImage: UIImage(named: AppImage.DiseaseImage.TomatoBacterialSpot) ?? UIImage(named: AppImage.Icon.PlaceholderPhoto)!,
            diseaseName: Localization.CornDisease.CornGraySpot.localized(),
            plantName: Localization.CornDisease.CornGraySpot.localized(),
            typeDisease: Localization.Result.Fungus.localized(),
            threatLevel: Localization.Result.HighLevel.localized(),
            symptomInfo: Localization.CornDisease.CornGraySpotAbout.localized(),
            conditionInfo: Localization.CornDisease.CornGraySpotCondition.localized(),
            treatmentInfo: Localization.CornDisease.CornGraySpotTreatment.localized(),
            certainty: 0),
    Disease(diseaseImage: UIImage(named: AppImage.DiseaseImage.TomatoBacterialSpot) ?? UIImage(named: AppImage.Icon.PlaceholderPhoto)!,
            diseaseName: Localization.CornDisease.Corn.localized(),
            plantName: Localization.CornDisease.CornGraySpot.localized(),
            typeDisease: Localization.Result.Fungus.localized(),
            threatLevel: Localization.Result.HighLevel.localized(),
            symptomInfo: Localization.CornDisease.CornGraySpotAbout.localized(),
            conditionInfo: Localization.CornDisease.CornGraySpotCondition.localized(),
            treatmentInfo: Localization.CornDisease.CornGraySpotTreatment.localized(),
            certainty: 0)
    ]
}
