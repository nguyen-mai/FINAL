import UIKit

class ForumVC: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = AppColor.GreenColor
        navigationController?.navigationItem.titleView?.tintColor = AppColor.WhiteColor
        navigationController?.navigationBar.tintColor = AppColor.WhiteColor
        
        let label = UILabel()
        label.textColor = AppColor.WhiteColor
        label.text = Localization.Forum.Forum.localized()
        label.font = UIFont(name: "Noteworthy Bold", size: 20)
        navigationItem.titleView = label
//        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: AppImage.Icon.User)?.withRenderingMode(.alwaysOriginal),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(leftBtnTap))
    
        let rightBtn = UIBarButtonItem(image: UIImage(named: AppImage.Icon.Post)?.withRenderingMode(.alwaysOriginal),
                                       style: .plain, target: self, action: #selector(rightBtnTap))
        navigationItem.rightBarButtonItem = rightBtn
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

// MARK: - Handle action
extension ForumVC {
    @objc private func rightBtnTap() {
        let vc = UIStoryboard(name: NameConstant.Storyboard.Forum,
                              bundle: nil).instantiateVC(PostVC.self)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func leftBtnTap() {
        let vc = UIStoryboard(name: NameConstant.Storyboard.Forum,
                              bundle: nil).instantiateVC(AccountVC.self)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}
