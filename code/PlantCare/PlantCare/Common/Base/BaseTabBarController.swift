import Foundation
import UIKit

class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        setupCommon()
        setupTabBarItem()
        setupMiddleButton()
    }
    
    private func setupCommon() {
        tabBar.tintColor = AppColor.GreenColor
        tabBar.isTranslucent = false
        tabBar.backgroundColor = AppColor.WhiteColor
        tabBar.setTopBorderWithColor(color: AppColor.LightGrayColor1!, height: 1)
        selectedIndex = 0
        delegate = self
    }
    
    private func setupTabBarItem() {
        let homeVC = UIStoryboard(name: NameConstant.Storyboard.Home,
                                  bundle: nil).instantiateVC(HomeVC.self)
        let homeNavController = BaseNavigationController(rootViewController: homeVC)
        homeNavController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: AppImage.Icon.HomeTabItem),
            tag: 0)
        
        let cameraVC = UIStoryboard(name: NameConstant.Storyboard.Camera,
                                  bundle: nil).instantiateVC(CameraVC.self)
        cameraVC.tabBarItem = UITabBarItem(
            title: nil,
            image: nil,
            tag: 1)

        let forumVC = UIStoryboard(name: NameConstant.Storyboard.Forum,
                                  bundle: nil).instantiateVC(ForumVC.self)
        let forumNavController = BaseNavigationController(rootViewController: forumVC)
        forumNavController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: AppImage.Icon.ForumTabItem),
            tag: 2)
        
        viewControllers = [homeNavController, cameraVC, forumNavController]
        
        let items = tabBar.items
        guard let items = items else {
            return
        }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    
    private func setupMiddleButton() {
        let middleButton = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 30,
                                                  y: -25,
                                                  width: 60,
                                                  height: 60))
        middleButton.setBackgroundImage(UIImage(named: AppImage.Icon.CameraTabItem), for: .normal)
        middleButton.layer.shadowColor = AppColor.BlackColor?.cgColor
        middleButton.layer.shadowOpacity = 0.3
        middleButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        tabBar.addSubviews(middleButton)
        middleButton.addTarget(self, action: #selector(middleBtnTap), for: .touchUpInside)
        
        view.layoutIfNeeded()
    }
}

// MARK: - Handle Actions
extension BaseTabBarController: UITabBarControllerDelegate {
    @objc private func middleBtnTap() {
        selectedIndex = 1
    }
    
    func hideTabBar() {
        tabBar.isHidden = true
    }

    func showTabBar() {
        tabBar.isHidden = false
    }
}
