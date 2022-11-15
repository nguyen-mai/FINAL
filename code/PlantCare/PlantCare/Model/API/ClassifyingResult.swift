import Foundation

struct ClassifyingResult {
    let uid: String
    let imageUrl: String
    let plantName: String
    let diseaseName: String
    let creationDate: Date
    let certainty: Double
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid as? String ?? ""
        self.imageUrl = dictionary["image_url"] as? String ?? ""
        self.plantName = dictionary["plant_name"] as? String ?? ""
        self.diseaseName = dictionary["disease_name"] as? String ?? ""
        self.certainty = dictionary["certainty"] as? Double ?? 0
        let secondsFrom1970 = dictionary["creation_date"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
