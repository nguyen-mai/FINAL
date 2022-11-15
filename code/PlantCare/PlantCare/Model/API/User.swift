import Foundation

struct User {
    
    let uid: String
    let username: String
    let email: String
    let profileImageUrl: String?
    
    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profile_image_url"] as? String ?? nil
    }
}
