import UIKit
import Firebase
import ProgressHUD

import UIKit
import Firebase

class ForumVC: CommunityPostCellViewController {
       
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(CommunityPostCell.self, forCellWithReuseIdentifier: CommunityPostCell.cellId)
        collectionView?.backgroundView = CommunityEmptyStateView()
        collectionView?.backgroundView?.alpha = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleRefresh), name: NSNotification.Name.updateCommunityFeed, object: nil)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        fetchAllPosts()
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

    @objc func rightBtnTapped() {
        let storyboard = UIStoryboard(name: "Forum", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "PostVC") as? PostVC else {
            return
        }
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func fetchAllPosts() {
        collectionView?.refreshControl?.beginRefreshing()
        
        Database.database().fetchAllUsers(includeCurrentUser: true, completion: { (users) in
            for user in users {
                Database.database().fetchAllPosts(withUID: user.uid, completion: { (posts) in
                    self.posts.append(contentsOf: posts)
                    
                    self.posts.sort(by: { (p1, p2) -> Bool in
                        return p1.creationDate.compare(p2.creationDate) == .orderedDescending
                    })
                    
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
        height += dummyCell.captionLabel.intrinsicContentSize.height + 8
        return CGSize(width: view.frame.width, height: height)
    }
}
