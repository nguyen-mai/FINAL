import Foundation
import Firebase

// MARK: - Auth
extension Auth {
    func logIn(email: String, password: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, err) in
            if err != nil {
                completion(err)
                return
            }
            completion(nil)
        })
    }
    
    func createUser(withEmail email: String, username: String, password: String, image: UIImage?, completion: @escaping (Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, err) in
            if let err = err {
                print("Failed to create user:", err.localizedDescription)
                completion(err)
                return
            }
            guard let uid = user?.user.uid else { return }
            if let image = image {
                Storage.storage().uploadUserProfileImage(image: image, completion: { (profileImageUrl) in
                    self.uploadUser(withUID: uid, email: email, username: username, profileImageUrl: profileImageUrl) {
                        completion(nil)
                    }
                })
            } else {
                self.uploadUser(withUID: uid, email: email, username: username, profileImageUrl: nil) {
                    completion(nil)
                }
            }
        })
    }
    
    private func uploadUser(withUID uid: String, email: String, username: String, profileImageUrl: String? = nil, completion: @escaping (() -> ())) {
        var dictionaryValues = ["username": username, "email": email]
        if profileImageUrl != nil {
            dictionaryValues["profile_image_url"] = profileImageUrl
        } else {
            dictionaryValues["profile_image_url"] = "nil"
        }
        let values = [uid: dictionaryValues]
        Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
            if let err = err {
                print("Failed to upload user to database:", err)
                return
            }
            completion()
        })
    }
}

// MARK: - Storage
extension Storage {
    fileprivate func uploadUserProfileImage(image: UIImage, completion: @escaping (String) -> ()) {
        guard let uploadData = image.jpegData(compressionQuality: 1) else { return } //changed from 0.3
        
        let storageRef = Storage.storage().reference().child("profile_images").child(NSUUID().uuidString)
        
        storageRef.putData(uploadData, metadata: nil, completion: { (_, err) in
            if let err = err {
                print("Failed to upload profile image:", err)
                return
            }
            
            storageRef.downloadURL(completion: { (downloadURL, err) in
                if let err = err {
                    print("Failed to obtain download url for profile image:", err)
                    return
                }
                guard let profileImageUrl = downloadURL?.absoluteString else { return }
                completion(profileImageUrl)
            })
        })
    }
    
    fileprivate func uploadPostImage(image: UIImage, filename: String, completion: @escaping (String) -> ()) {
        guard let uploadData = image.jpegData(compressionQuality: 1) else { return } //changed from 0.5
        
        let storageRef = Storage.storage().reference().child("post_images").child(filename)
        storageRef.putData(uploadData, metadata: nil, completion: { (_, err) in
            if let err = err {
                print("Failed to upload post image:", err.localizedDescription)
                return
            }
            
            storageRef.downloadURL(completion: { (downloadURL, err) in
                if let err = err {
                    print("Failed to obtain download url for post image:", err)
                    return
                }
                guard let postImageUrl = downloadURL?.absoluteString else { return }
                completion(postImageUrl)
            })
        })
    }
    
    fileprivate func uploadRelabeledDiseaseImage(image: UIImage, filename: String, completion: @escaping (String) -> ()) {
        guard let uploadData = image.jpegData(compressionQuality: 1) else { return } //changed from 0.5
        
        let storageRef = Storage.storage().reference().child("relabeled_diseases_images").child(filename)
        storageRef.putData(uploadData, metadata: nil, completion: { (_, err) in
            if let err = err {
                print("Failed to upload post image:", err.localizedDescription)
                return
            }
            
            storageRef.downloadURL(completion: { (downloadURL, err) in
                if let err = err {
                    print("Failed to obtain download url for post image:", err)
                    return
                }
                guard let postImageUrl = downloadURL?.absoluteString else { return }
                completion(postImageUrl)
            })
        })
    }
    
    fileprivate func uploadClassifyingResult(image: UIImage, filename: String, completion: @escaping (String) -> ()) {
        guard let uploadData = image.jpegData(compressionQuality: 1) else { return } //changed from 0.5
        
        let storageRef = Storage.storage().reference().child("classifying_results").child(filename)
        storageRef.putData(uploadData, metadata: nil, completion: { (_, err) in
            if let err = err {
                print("Failed to upload post image:", err.localizedDescription)
                return
            }
            
            storageRef.downloadURL(completion: { (downloadURL, err) in
                if let err = err {
                    print("Failed to obtain download url for post image:", err)
                    return
                }
                guard let postImageUrl = downloadURL?.absoluteString else { return }
                completion(postImageUrl)
            })
        })
    }
}

// MARK: - Real Time
extension Database {
    //MARK: Users
    func fetchUser(withUID uid: String, completion: @escaping (User) -> ()) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let userDictionary = snapshot.value as? [String: Any] else { return }
            let user = User(uid: uid, dictionary: userDictionary)
            completion(user)
        }) { (err) in
            print("Failed to fetch user from database:", err)
        }
    }
    
    func fetchAllUsers(includeCurrentUser: Bool = true, completion: @escaping ([User]) -> (), withCancel cancel: ((Error) -> ())?) {
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else {
                completion([])
                return
            }
            
            var users = [User]()
            
            dictionaries.forEach({ (key, value) in
                if !includeCurrentUser, key == Auth.auth().currentUser?.uid {
                    completion([])
                    return
                }
                guard let userDictionary = value as? [String: Any] else { return }
                let user = User(uid: key, dictionary: userDictionary)
                users.append(user)
            })
            
            users.sort(by: { (user1, user2) -> Bool in
                return user1.username.compare(user2.username) == .orderedAscending
            })
            completion(users)
            
        }) { (err) in
            print("Failed to fetch all users from database:", (err))
            cancel?(err)
        }
    }
    
    func updateUserProfileImage(withImage image: UIImage, completion: @escaping (Error?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userInfoRef = Database.database().reference().child("users").child(uid)
        Storage.storage().uploadUserProfileImage(image: image, completion: { (profileImageUrl) in
            let values = ["profile_image_url": profileImageUrl] as [String : Any]
            userInfoRef.updateChildValues(values) { (err, ref) in
                if let err = err {
                    print("Failed to save post to database", err)
                    completion(err)
                    return
                }
                completion(nil)
            }
        })
    }
    
    func updateUserEmail(newEmail: String, password: String, completion: @escaping (Error?) -> ()) {
        let currentUser = Auth.auth().currentUser
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userInfoRef = Database.database().reference().child("users").child(uid)
        guard let currentEmail = currentUser?.email else {return}
        let credential = EmailAuthProvider.credential(withEmail: currentEmail, password: password)
        currentUser?.reauthenticate(with: credential, completion: { (result, error) in
            if error != nil {
                print("ERROR: ", error?.localizedDescription ?? "")
                completion(error)
                return
            }
            currentUser?.updateEmail(to: newEmail, completion: { (error) in
                if error != nil {
                    print("ERROR: ", error?.localizedDescription ?? "")
                    completion(error)
                    return
                }else {
                    let thisUserEmailRef = userInfoRef.child("email")
                    thisUserEmailRef.setValue(newEmail)
                    completion(nil)
                }
            })
        })
    }
    
    func updateUserPassord(newPassword: String, password: String, completion: @escaping (Error?) -> ()) {
        let currentUser = Auth.auth().currentUser
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userInfoRef = Database.database().reference().child("users").child(uid)
        guard let currentEmail = currentUser?.email else {return}
        let credential = EmailAuthProvider.credential(withEmail: currentEmail, password: password)
        currentUser?.reauthenticate(with: credential, completion: { (result, error) in
            if error != nil {
                print("ERROR: ", error?.localizedDescription ?? "")
                completion(error)
                return
            }
            currentUser?.updatePassword(to: password, completion: { (error) in
                if error != nil {
                    print("ERROR: ", error?.localizedDescription ?? "")
                    completion(error)
                    return
                } else {
                    completion(nil)
                }
            })
        })
    }
    
    func updateUserName(withUserName username: String, completion: @escaping (Error?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userInfoRef = Database.database().reference().child("users").child(uid)
        let values = ["username": username] as [String : Any]
        userInfoRef.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Failed to save post to database", err)
                completion(err)
                return
            }
            completion(nil)
        }
    }
    
    //MARK: Posts
    func createPost(withImage image: UIImage, caption: String, completion: @escaping (Error?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userPostRef = Database.database().reference().child("posts").child(uid).childByAutoId()
        
        guard let postId = userPostRef.key else { return }
        
        Storage.storage().uploadPostImage(image: image, filename: postId) { (postImageUrl) in
            let values = ["image_url": postImageUrl, "caption": caption, "image_width": image.size.width, "image_height": image.size.height, "creation_date": Date().timeIntervalSince1970, "id": postId] as [String : Any]
            
            userPostRef.updateChildValues(values) { (err, ref) in
                if let err = err {
                    print("Failed to save post to database", err)
                    completion(err)
                    return
                }
                completion(nil)
            }
        }
    }
    
    func fetchPost(withUID uid: String, postId: String, completion: @escaping (Post) -> (), withCancel cancel: ((Error) -> ())? = nil) {
        guard let currentLoggedInUser = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference().child("posts").child(uid).child(postId)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let postDictionary = snapshot.value as? [String: Any] else { return }
            
            Database.database().fetchUser(withUID: uid, completion: { (user) in
                var post = Post(user: user, dictionary: postDictionary)
                post.id = postId
                
                //check likes
                Database.database().reference().child("likes").child(postId).child(currentLoggedInUser).observeSingleEvent(of: .value, with: { (snapshot) in
                    if let value = snapshot.value as? Int, value == 1 {
                        post.likedByCurrentUser = true
                    } else {
                        post.likedByCurrentUser = false
                    }
                    
                    Database.database().numberOfLikesForPost(withPostId: postId, completion: { (count) in
                        post.likes = count
                        completion(post)
                    })
                }, withCancel: { (err) in
                    print("Failed to fetch like info for post:", err)
                    cancel?(err)
                })
            })
        })
    }
    
    func fetchAllPosts(withUID uid: String, completion: @escaping ([Post]) -> (), withCancel cancel: ((Error) -> ())?) {
        let ref = Database.database().reference().child("posts").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else {
                completion([])
                return
            }

            var posts = [Post]()

            dictionaries.forEach({ (postId, value) in
                Database.database().fetchPost(withUID: uid, postId: postId, completion: { (post) in
                    posts.append(post)
                    
                    if posts.count == dictionaries.count {
                        completion(posts)
                    }
                })
            })
        }) { (err) in
            print("Failed to fetch posts:", err)
            cancel?(err)
        }
    }
    
    func deletePost(withUID uid: String, postId: String, completion: ((Error?) -> ())? = nil) {
        Database.database().reference().child("posts").child(uid).child(postId).removeValue { (err, _) in
            if let err = err {
                print("Failed to delete post:", err)
                completion?(err)
                return
            }
            
            Database.database().reference().child("comments").child(postId).removeValue(completionBlock: { (err, _) in
                if let err = err {
                    print("Failed to delete comments on post:", err)
                    completion?(err)
                    return
                }
                
                Database.database().reference().child("likes").child(postId).removeValue(completionBlock: { (err, _) in
                    if let err = err {
                        print("Failed to delete likes on post:", err)
                        completion?(err)
                        return
                    }
                    
                    Storage.storage().reference().child("post_images").child(postId).delete(completion: { (err) in
                        if let err = err {
                            print("Failed to delete post image from storage:", err)
                            completion?(err)
                            return
                        }
                    })
                    
                    completion?(nil)
                })
            })
        }
    }
    
    func addCommentToPost(withId postId: String, text: String, completion: @escaping (Error?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["text": text, "creation_date": Date().timeIntervalSince1970, "uid": uid] as [String: Any]
        
        let commentsRef = Database.database().reference().child("comments").child(postId).childByAutoId()
        commentsRef.updateChildValues(values) { (err, _) in
            if let err = err {
                print("Failed to add comment:", err)
                completion(err)
                return
            }
            completion(nil)
        }
    }
    
    func fetchCommentsForPost(withId postId: String, completion: @escaping ([Comment]) -> (), withCancel cancel: ((Error) -> ())?) {
        let commentsReference = Database.database().reference().child("comments").child(postId)
        
        commentsReference.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else {
                completion([])
                return
            }
            
            var comments = [Comment]()
            
            dictionaries.forEach({ (key, value) in
                guard let commentDictionary = value as? [String: Any] else { return }
                guard let uid = commentDictionary["uid"] as? String else { return }
                
                Database.database().fetchUser(withUID: uid) { (user) in
                    let comment = Comment(user: user, dictionary: commentDictionary)
                    comments.append(comment)
                    
                    if comments.count == dictionaries.count {
                        comments.sort(by: { (comment1, comment2) -> Bool in
                            return comment1.creationDate.compare(comment2.creationDate) == .orderedAscending
                        })
                        completion(comments)
                    }
                }
            })
            
        }) { (err) in
            print("Failed to fetch comments:", err)
            cancel?(err)
        }
    }
    
    //MARK: Utilities
    func numberOfPostsForUser(withUID uid: String, completion: @escaping (Int) -> ()) {
        Database.database().reference().child("posts").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionaries = snapshot.value as? [String: Any] {
                completion(dictionaries.count)
            } else {
                completion(0)
            }
        }
    }
    
    func numberOfLikesForPost(withPostId postId: String, completion: @escaping (Int) -> ()) {
        Database.database().reference().child("likes").child(postId).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionaries = snapshot.value as? [String: Any] {
                completion(dictionaries.count)
            } else {
                completion(0)
            }
        }
    }
    
    // MARK: Relabel disease image
    func createRelabelImage(withImage image: UIImage, plantName: String, diseaseName: String, completion: @escaping (Error?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userPostRef = Database.database().reference().child("relabel_disease_images").child(uid).childByAutoId()
        
        guard let postId = userPostRef.key else { return }
        
        Storage.storage().uploadRelabeledDiseaseImage(image: image, filename: postId) { (postImageUrl) in
            let values = ["image_url": postImageUrl, "plant_name": plantName, "disease_name": diseaseName, "image_width": image.size.width, "image_height": image.size.height, "creation_date": Date().timeIntervalSince1970, "id": postId] as [String : Any]
            userPostRef.updateChildValues(values) { (err, ref) in
                if let err = err {
                    print("Failed to save post to database", err)
                    completion(err)
                    return
                }
                completion(nil)
            }
        }
    }
    
    // MARK: Searching Result
    func createClassifyingResult(withImage image: UIImage, plantName: String, diseaseName: String, certainty: Double, completion: @escaping (Error?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userPostRef = Database.database().reference().child("classifying_results").child(uid).childByAutoId()
        guard let postId = userPostRef.key else { return }
        
        Storage.storage().uploadClassifyingResult(image: image, filename: postId) { (postImageUrl) in
            let values = ["image_url": postImageUrl, "plant_name": plantName, "disease_name": diseaseName, "certainty": certainty,"image_width": image.size.width, "image_height": image.size.height, "creation_date": Date().timeIntervalSince1970, "id": postId] as [String : Any]
            userPostRef.updateChildValues(values) { (err, ref) in
                if let err = err {
                    print("Failed to save post to database", err)
                    completion(err)
                    return
                }
                completion(nil)
            }
        }
    }
    
    func fetchClassifyingResult(postId: String, completion: @escaping (ClassifyingResult) -> (), withCancel cancel: ((Error) -> ())? = nil) {
        guard let currentLoggedInUser = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference().child("classifying_results").child(currentLoggedInUser).child(postId)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let postDictionary = snapshot.value as? [String: Any] else { return }
            let post = ClassifyingResult(uid: postId, dictionary: postDictionary)
            completion(post)
        })
    }
    
    func fetchAllClassifyingResult(completion: @escaping ([ClassifyingResult]) -> (), withCancel cancel: ((Error) -> ())?) {
        guard let currentLoggedInUser = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("classifying_results").child(currentLoggedInUser)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else {
                completion([])
                return
            }

            var posts = [ClassifyingResult]()
            dictionaries.forEach({ (postId, value) in
                Database.database().fetchClassifyingResult(postId: postId, completion: { (post) in
                    posts.append(post)
                    print(posts.count)
                    if posts.count == dictionaries.count {
                        print(posts.count)
                        completion(posts)
                    }
                })
            })
        }) { (err) in
            print("Failed to fetch posts:", err)
            cancel?(err)
        }
    }
    
    func deleteClassifyingResult(resultId: String, completion: ((Error?) -> ())? = nil) {
        guard let currentLoggedInUser = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("classifying_results").child(currentLoggedInUser).child(resultId).removeValue { (err, _) in
            if let err = err {
                print("Failed to delete post:", err)
                completion?(err)
                return
            }
            
            Storage.storage().reference().child("classifying_results").child(resultId).delete(completion: { (err) in
                if let err = err {
                    print("Failed to delete post image from storage:", err)
                    completion?(err)
                    return
                }
            })
            completion?(nil)
        }
    }
}
