import UIKit
import Firebase
import ProgressHUD

class AccountVC: CommunityPostCellViewController {
    var user: User?
    var uid: String = ""
    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        ProgressHub.shared.setupProgressHub()
        
        if uid == Auth.auth().currentUser?.uid {
            showEmptyStateViewIfNeeded()
            fetchCurrentUser()
        } else if !uid.isEmpty {
            showEmptyStateViewIfNeeded()
            fetchOtherUser()
        }
        else {
            showAlert(title: Localization.Alert.NotLogIn.localized())
        }
        
        collectionView?.backgroundColor = .white
        collectionView?.register(CommunityPostCell.self, forCellWithReuseIdentifier: CommunityPostCell.cellId)
        collectionView?.backgroundView = CommunityEmptyStateView()
        collectionView?.backgroundView?.alpha = 0
        collectionView.showsVerticalScrollIndicator = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleRefresh), name: NSNotification.Name.updateCommunityFeed, object: nil)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
    }
    
    private func fetchCurrentUser() {
        ProgressHUD.show()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.uid = uid
        Database.database().fetchUser(withUID: uid) { (user) in
            self.user = user
            self.fetchPosts()
            self.collectionView.reloadData()
        }
        ProgressHUD.dismiss()
    }
    
    private func fetchOtherUser() {
        ProgressHUD.show()
        guard let user = user else {
            return
        }
        self.uid = user.uid
        Database.database().fetchUser(withUID: uid) { (user) in
            self.user = user
            self.fetchPosts()
            self.collectionView.reloadData()
        }
        ProgressHUD.dismiss()
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.backgroundColor = AppColor.GreenColor
        navigationController?.navigationItem.titleView?.tintColor = AppColor.WhiteColor
        navigationController?.navigationBar.tintColor = AppColor.WhiteColor

        let label = UILabel()
        label.textColor = AppColor.WhiteColor
        label.text = Localization.TitleApp.Title
        label.font = UIFont(name: "Noteworthy Bold", size: 20)
        navigationItem.titleView = label
        
        let rightBtn = UIBarButtonItem(image: UIImage(named: AppImage.Icon.LogOut)?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightBtnTapped))
        navigationItem.rightBarButtonItem = rightBtn
        
        let leftBtn = UIBarButtonItem(image: UIImage(named: AppImage.Icon.Back)?.withTintColor(AppColor.WhiteColor!), style: .plain, target: self, action: #selector(leftBtnTapped))
        navigationItem.leftBarButtonItem = leftBtn
    }
    
    @objc private func rightBtnTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Localization.Alert.LogOut.localized(), style: .destructive, handler: { _ in
            try! Auth.auth().signOut()
            let vc = UIStoryboard(name: NameConstant.Storyboard.Authenticate,
                                  bundle: nil).instantiateVC(LoginVC.self)
            let navBar = BaseNavigationController(rootViewController: vc)
            UIApplication.shared.windows.first?.rootViewController = navBar
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
            UserDefaults.standard.set(EnumConstant.OnboardingStatus.LoggedIn.rawValue,
                                      forKey: NameConstant.UserDefaults.HasOnboarding)
        }))
        alert.addAction(UIAlertAction(title: Localization.Alert.Cancel.localized(), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func leftBtnTapped() {
        navigationController?.popViewController(animated: true)
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
                
            }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func fetchPosts() {
        collectionView?.refreshControl?.beginRefreshing()
//        ProgressHUD.show()
        
        guard let user = user else {
            return
        }
        
        Database.database().fetchAllPosts(withUID: user.uid, completion: { (posts) in
            self.posts.append(contentsOf: posts)
            
            self.posts.sort(by: { (p1, p2) -> Bool in
                return p1.creationDate.compare(p2.creationDate) == .orderedDescending
            })
            self.collectionView?.reloadData()
            self.collectionView?.refreshControl?.endRefreshing()
//            ProgressHUD.dismiss()
        }) { (err) in
            self.collectionView?.refreshControl?.endRefreshing()
//            ProgressHUD.dismiss()
        }
    }
    
    override func showEmptyStateViewIfNeeded() {
        guard let currentLoggedInUserId = Auth.auth().currentUser?.uid else { return }
        Database.database().numberOfPostsForUser(withUID: currentLoggedInUserId, completion: { (postCount) in
            if postCount == 0 {
                UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
                    self.collectionView?.backgroundView?.alpha = 1
                }, completion: nil)
            } else {
                self.collectionView?.backgroundView?.alpha = 0
            }
        })
    }
    

    @objc private func handleRefresh() {
        posts.removeAll()
        showEmptyStateViewIfNeeded()
        fetchPosts()
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
extension AccountVC: UICollectionViewDelegateFlowLayout {
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
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerViewCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderProfileCollectionReusableView", for: indexPath) as! HeaderProfileCollectionReusableView
        if let user = self.user {
            headerViewCell.user = user
            headerViewCell.changedImage = selectedImage
            headerViewCell.delegate = self
        }
        return headerViewCell
    }
}

extension AccountVC: HeaderProfileCollectionReusableViewDelegateSwitchSettingVC {
    func updateImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    
    func goToSettingVC() {
        let vc = UIStoryboard(name: NameConstant.Storyboard.Forum,
                              bundle: nil).instantiateVC(PostVC.self)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AccountVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        Database.database().updateUserProfileImage(withImage: image, completion:  { (err) in
            ProgressHUD.show()
            if err != nil {
                ProgressHUD.showError(err?.localizedDescription.localized())
                return
            }
            self.selectedImage = image
            self.collectionView.reloadData()
            self.dismiss(animated: true, completion: nil)
            ProgressHUD.showSucceed()
        }
        )
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
