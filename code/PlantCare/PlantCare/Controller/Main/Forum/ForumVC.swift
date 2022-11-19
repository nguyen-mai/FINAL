import UIKit
import Firebase
import ProgressHUD

class ForumVC: CommunityPostCellViewController {
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        ProgressHub.shared.setupProgressHub()
        NotificationCenter.default.addObserver(self, selector: #selector(handleRefresh), name: NSNotification.Name.updateCommunityFeed, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(fetchCurrentUser), name: NSNotification.Name.updateUserProfileFeed, object: nil)
        
        if !(Auth.auth().currentUser == nil) {
            fetchCurrentUser()
            fetchAllPosts()
        } else {
            showAlert(title: Localization.Alert.NotLogIn)
        }
        
        collectionView?.backgroundColor = AppColor.WhiteColor
        collectionView?.register(CommunityPostCell.self, forCellWithReuseIdentifier: CommunityPostCell.cellId)
        collectionView?.backgroundView = CommunityEmptyStateView()
        collectionView?.backgroundView?.alpha = 0
        collectionView.showsVerticalScrollIndicator = false
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
    }
    
    @objc private func fetchCurrentUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Database.database().fetchUser(withUID: uid) { (user) in
            self.user = user
            self.collectionView.reloadData()
            self.configLeftButton()
        }
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = AppColor.GreenColor
        navigationController?.navigationItem.titleView?.tintColor = AppColor.WhiteColor
        navigationController?.navigationBar.tintColor = AppColor.WhiteColor

        let label = UILabel()
        label.textColor = AppColor.WhiteColor
        label.text = Localization.Forum.Forum.localized()
        label.font = UIFont(name: "Noteworthy Bold", size: 20)
        navigationItem.titleView = label
        
        let rightBtn = UIBarButtonItem(image: UIImage(named: AppImage.Icon.Post)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightBtnTapped))
        navigationItem.rightBarButtonItem = rightBtn
    }
    
    private func configLeftButton() {
        let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30))
        let iconButton = UIButton(frame: iconSize)
        let barButton = UIBarButtonItem(customView: iconButton)
        iconButton.imageView?.contentMode = .scaleToFill
        iconButton.addTarget(self, action: #selector(leftBtnTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = barButton
        
        let image = CustomImageView()
        if let profileImageUrl = user?.profileImageUrl, profileImageUrl != "nil" {
            image.loadImage(urlString: profileImageUrl)
        } else {
            image.image = UIImage(named: AppImage.Icon.User)?.withTintColor(AppColor.WhiteColor!)
        }
        image.frame = iconButton.frame
        image.layer.borderColor = AppColor.WhiteColor?.cgColor
        image.layer.borderWidth = 0.5
        image.layer.cornerRadius = iconButton.frame.height / 2
        image.layer.masksToBounds = true
        iconButton.addSubviews(image)
    }
    
    @objc func rightBtnTapped() {
        let storyboard = UIStoryboard(name: "Forum", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "PostVC") as? PostVC else {
            return
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func leftBtnTapped() {
        let storyboard = UIStoryboard(name: "Forum", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "AccountVC") as? AccountVC else {
            return
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        vc.uid = Auth.auth().currentUser?.uid ?? ""
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showAlert(title: String) {
        let alert = UIAlertController(title: title,
                                      message: "",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: Localization.Alert.GoLogIn.localized(),
            style: .default) { _ in
                let vc = UIStoryboard(name: NameConstant.Storyboard.Authenticate,
                                      bundle: nil).instantiateVC(LoginVC.self)
                let navBar = BaseNavigationController(rootViewController: vc)
                UIApplication.shared.windows.first?.rootViewController = navBar
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                
                UserDefaults.standard.set(EnumConstant.OnboardingStatus.LoggedIn.rawValue,
                                          forKey: NameConstant.UserDefaults.HasOnboarding)
        }
        let cancelAction = UIAlertAction(
            title: Localization.Alert.ReturnPage.localized(),
            style: .cancel) { _ in
                self.tabBarController?.selectedIndex = 0
                self.navigationController?.popViewController(animated: true)
            }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func fetchAllPosts() {
        collectionView?.refreshControl?.beginRefreshing()
        self.posts.removeAll()
        Database.database().fetchAllUsers(includeCurrentUser: true, completion: { (users) in
            ProgressHUD.show()
            for user in users {
                Database.database().fetchAllPosts(withUID: user.uid, completion: { (posts) in
                    self.posts.append(contentsOf: posts)
                    self.posts.sort(by: { (p1, p2) -> Bool in
                        return p1.creationDate.compare(p2.creationDate) == .orderedDescending
                    })
                    self.collectionView?.reloadData()
                    self.collectionView?.refreshControl?.endRefreshing()
                    ProgressHUD.dismiss()
                }) { (err) in
                    self.collectionView?.reloadData()
                    ProgressHUD.show(err.localizedDescription.localized())
                    self.collectionView?.refreshControl?.endRefreshing()
                }
            }
        }) {  (_) in
            self.collectionView?.refreshControl?.endRefreshing()
        }
    }
    

    @objc private func handleRefresh() {
        posts.removeAll()
        fetchAllPosts()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunityPostCell.cellId, for: indexPath) as! CommunityPostCell
        if indexPath.item < posts.count {
            cell.post = posts[indexPath.item]
        }
        cell.delegate = self
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ForumVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dummyCell = CommunityPostCell(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1000))
        dummyCell.post = posts[indexPath.item]
        dummyCell.layoutIfNeeded()
        
        var height: CGFloat = dummyCell.header.bounds.height
        height += view.frame.width
        height += 24 + 2 * dummyCell.padding //bookmark button + padding
        switch indexPath.item {
        case posts.count - 1:
            height += dummyCell.captionLabel.intrinsicContentSize.height + 2 * 20
        default:
            height += dummyCell.captionLabel.intrinsicContentSize.height + 8
        }
        return CGSize(width: view.frame.width, height: height)
    }
}
