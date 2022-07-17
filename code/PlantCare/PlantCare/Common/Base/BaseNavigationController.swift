import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        UIBarButtonItem.appearance().tintColor = AppColor.WhiteColor
        UINavigationBar.appearance().backgroundColor = AppColor.GreenColor
        UINavigationBar.appearance().barTintColor = AppColor.GreenColor
    }
}
