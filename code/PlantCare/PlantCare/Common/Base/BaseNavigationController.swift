import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
//        UIBarButtonItem.appearance().tintColor = AppColor.WhiteColor
////        UINavigationBar.appearance().backgroundColor = AppColor.WhiteColor
////        UINavigationBar.appearance().barTintColor = AppColor.WhiteColor
//
//        if #available(iOS 13.0, *) {
//            let navBarAppearance = UINavigationBarAppearance()
//            navBarAppearance.configureWithOpaqueBackground()
//            navBarAppearance.backgroundColor = AppColor.GreenColor
//            self.navigationBar.standardAppearance = navBarAppearance
//            self.navigationBar.scrollEdgeAppearance = navBarAppearance
//        } else {
//            self.edgesForExtendedLayout = []
//        }
    }
}

