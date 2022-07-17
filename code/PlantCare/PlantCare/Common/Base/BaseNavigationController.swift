import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        UIBarButtonItem.appearance().tintColor = AppColor.GreenColor
        UINavigationBar.appearance().backgroundColor = AppColor.WhiteColor
        UINavigationBar.appearance().barTintColor = AppColor.WhiteColor
    }
}
