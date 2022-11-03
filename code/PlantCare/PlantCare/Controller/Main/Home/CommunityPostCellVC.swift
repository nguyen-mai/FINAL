//
//  CommunityPostCellVC.swift
//  PlantCare
//
//  Created by Apple on 2022/3/27.
//

import UIKit
import Firebase

class CommunityPostCellViewController: UICollectionViewController, CommunityPostCellDelegate {
  
    var posts = [Post]()
    
    func showEmptyStateViewIfNeeded() {}
    
    //MARK: - CommunityPostCellDelegate
    
    func didTapComment(post: Post) {
        let commentsController = CommentsVC(collectionViewLayout: UICollectionViewFlowLayout())
        commentsController.post = post
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        navigationController?.pushViewController(commentsController, animated: true)
    }
    
    func didTapUser(user: User) {
//        let userProfileController = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
//        userProfileController.user = user
//        navigationController?.pushViewController(userProfileController, animated: true)
    }
    
    func didTapOptions(post: Post) {
        guard let currentLoggedInUserId = Auth.auth().currentUser?.uid else { return }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if currentLoggedInUserId == post.user.uid {
            if let deleteAction = deleteAction(forPost: post) {
                alertController.addAction(deleteAction)
            }
        } 
        present(alertController, animated: true, completion: nil)
    }
    
    private func deleteAction(forPost post: Post) -> UIAlertAction? {
        guard let currentLoggedInUserId = Auth.auth().currentUser?.uid else { return nil }
        
        let action = UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            
            let alert = UIAlertController(title: "Delete Post?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (_) in
                
                Database.database().deletePost(withUID: currentLoggedInUserId, postId: post.id) { (_) in
                    if let postIndex = self.posts.index(where: {$0.id == post.id}) {
                        self.posts.remove(at: postIndex)
                        self.collectionView?.reloadData()
                        self.showEmptyStateViewIfNeeded()
                    }
                }
            }))
            self.present(alert, animated: true, completion: nil)
        })
        return action
    }
    
    func didLike(for cell: CommunityPostCell) {
        guard let indexPath = collectionView?.indexPath(for: cell) else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        var post = posts[indexPath.item]
        
        if post.likedByCurrentUser {
            Database.database().reference().child("likes").child(post.id).child(uid).removeValue { (err, _) in
                if let err = err {
                    print("Failed to unlike post:", err)
                    return
                }
                post.likedByCurrentUser = false
                post.likes = post.likes - 1
                self.posts[indexPath.item] = post
                UIView.performWithoutAnimation {
                    self.collectionView?.reloadItems(at: [indexPath])
                }
            }
        } else {
            let values = [uid : 1]
            Database.database().reference().child("likes").child(post.id).updateChildValues(values) { (err, _) in
                if let err = err {
                    print("Failed to like post:", err)
                    return
                }
                post.likedByCurrentUser = true
                post.likes = post.likes + 1
                self.posts[indexPath.item] = post
                UIView.performWithoutAnimation {
                    self.collectionView?.reloadItems(at: [indexPath])
                }
            }
        }
    }
}
