import Foundation
import ProgressHUD

struct ProgressHub {
    static let shared = ProgressHub()
    
    func setupProgressHub() {
        ProgressHUD.colorHUD = .clear
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.colorAnimation = AppColor.GreenColor!
    }
}
