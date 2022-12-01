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
        var treatmentInfo: String
        var certainty: Double
        
        init(diseaseImage: UIImage = UIImage(named: AppImage.Icon.PlaceholderPhoto) ?? UIImage(named: AppImage.Icon.PlaceholderPhoto)!,
             diseaseName: String = "",
             plantName: String = "",
             typeDisease: String = "",
             threatLevel: String = "",
             symptomInfo: String = "",
             treatmentInfo: String = "",
             certainty: Double = 0) {
            self.diseaseImage = diseaseImage
            self.diseaseName = diseaseName
            self.plantName = plantName
            self.typeDisease = typeDisease
            self.threatLevel = threatLevel
            self.symptomInfo = symptomInfo
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
                treatmentInfo: Localization.CornDisease.CornGraySpotTreatment.localized(),
                certainty: 0),
        Disease(diseaseImage: UIImage(named: AppImage.DiseaseImage.AppleScab) ?? UIImage(named: AppImage.Icon.PlaceholderPhoto)!,
            diseaseName: Localization.AppleDisease.AppleScab.localized(),
            plantName: Localization.AppleDisease.Apple.localized(),
            typeDisease: Localization.Result.Fungus.localized(),
            threatLevel: Localization.Result.HighLevel.localized(),
            symptomInfo: Localization.AppleDisease.AppleScabAbout.localized(),
            treatmentInfo: Localization.AppleDisease.AppleScabTreatment.localized(),
            certainty: 0),
        Disease(diseaseImage: UIImage(named: AppImage.DiseaseImage.TomatoBacterialSpot) ?? UIImage(named: AppImage.Icon.PlaceholderPhoto)!,
                diseaseName: Localization.Tomato.TomatoBacterialSpot.TomatoBacterialSpot.localized(),
            plantName: Localization.CornDisease.CornGraySpot.localized(),
            typeDisease: Localization.Result.Bacterial.localized(),
            threatLevel: Localization.Result.MediumLevel.localized(),
            symptomInfo: Localization.Tomato.TomatoBacterialSpot.TomatoBacterialSpotAbout.localized(),
            treatmentInfo: Localization.Tomato.TomatoBacterialSpot.TomatoBacterialSpotTreatment.localized(),
            certainty: 0),
        Disease(diseaseImage: UIImage(named: AppImage.DiseaseImage.TomatoEarlyBlight) ?? UIImage(named: AppImage.Icon.PlaceholderPhoto)!,
                diseaseName: Localization.Tomato.TomatoEarlyBlight.TomatoEarlyBlight.localized(),
            plantName: Localization.Tomato.Tomato.localized(),
            typeDisease: Localization.Result.Fungi.localized(),
            threatLevel: Localization.Result.MediumLevel.localized(),
            symptomInfo: Localization.Tomato.TomatoEarlyBlight.TomatoEarlyBlighAbout.localized(),
            treatmentInfo: Localization.Tomato.TomatoEarlyBlight.TomatoEarlyBlighTreatment.localized(),
            certainty: 0)
    ]
}
