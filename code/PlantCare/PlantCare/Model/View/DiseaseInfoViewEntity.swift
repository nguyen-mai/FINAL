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
        var certainty: String
        
        init(diseaseImage: UIImage = UIImage(named: AppImage.Icon.PlaceholderPhoto) ?? UIImage(),
             diseaseName: String = "",
             plantName: String = "",
             typeDisease: String = "",
             threatLevel: String = "",
             symptomInfo: String = "",
             conditionInfo: String = "",
             treatmentInfo: String = "",
             certainty: String = "") {
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
}
