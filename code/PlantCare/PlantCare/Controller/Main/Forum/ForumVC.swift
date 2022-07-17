import UIKit
import Firebase
import ProgressHUD

class ForumVC: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        setupNavBar()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView?.backgroundColor = .white
//        collectionView?.register(CommunityPostCell.self, forCellWithReuseIdentifier: CommunityPostCell.cellId)
//        collectionView?.backgroundView = CommunityEmptyStateView()
        collectionView?.backgroundView?.alpha = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleRefresh), name: NSNotification.Name.updateCommunityFeed, object: nil)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        fetchAllPosts()
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
    
    private func fetchAllPosts() {
        collectionView?.refreshControl?.beginRefreshing()
        
        Database.database().fetchAllUsers(includeCurrentUser: true, completion: { (users) in
            for user in users {
                Database.database().fetchAllPosts(withUID: user.uid, completion: { (posts) in
//                    self.posts.append(contentsOf: posts)
//
//                    self.posts.sort(by: { (p1, p2) -> Bool in
//                        return p1.creationDate.compare(p2.creationDate) == .orderedDescending
//                    })
                    
                    self.collectionView?.reloadData()
                    self.collectionView?.refreshControl?.endRefreshing()
                }) { (err) in
                    self.collectionView?.refreshControl?.endRefreshing()
                }
            }
        }) {  (_) in
            self.collectionView?.refreshControl?.endRefreshing()
        }
    }
    

    @objc private func handleRefresh() {
//        posts.removeAll()
        fetchAllPosts()
    }
}
