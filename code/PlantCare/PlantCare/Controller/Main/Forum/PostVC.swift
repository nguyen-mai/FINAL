import UIKit
//import Firebase

class PostVC: UIViewController {
    
    @IBOutlet private weak var photo: UIImageView!
    @IBOutlet private weak var captionTextView: UITextView!
    @IBOutlet private weak var shareButton: UIButton!
    
    private var selectedImage = UIImage(named: AppImage.Icon.PlaceholderPhoto) {
        didSet {
            photo.image = selectedImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupNavBar()
    }
    
    private func configUI() {        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectPhoto))
        photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true
        photo.image = selectedImage
        
        captionTextView.text = Localization.Forum.PlaceholderProblem.localized()
        captionTextView.textColor = UIColor.lightGray
        captionTextView.delegate = self
        
        shareButton.layer.cornerRadius = 20
    }
    
    private func setupNavBar() {
        let label = UILabel()
        label.textColor = AppColor.WhiteColor
        label.text = Localization.Forum.Post.localized()
        label.font = UIFont(name: "Noteworthy Bold", size: 20)
        navigationItem.titleView = label
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handlePost()
    }
    
    private func handlePost() {
        if selectedImage != nil {
           self.shareButton.isEnabled = true
            self.shareButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
           self.shareButton.isEnabled = false
            self.shareButton.backgroundColor = .lightGray

        }
    }
    
    private func clean() {
        self.captionTextView.text = ""
        self.photo.image = UIImage(named: AppImage.Icon.PlaceholderPhoto)
        self.selectedImage = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func handleSelectPhoto() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    
    @objc private func shareBtnTapped(_ sender: Any) {
//        guard let postImage = selectedImage else { return }
//        guard let caption = captionTextView.text else { return }
//
//        captionTextView.isUserInteractionEnabled = false
//
//        Database.database().createPost(withImage: postImage, caption: caption) { (err) in
//            if err != nil {
//                self.captionTextView.isUserInteractionEnabled = true
//                return
//            }
//
//            NotificationCenter.default.post(name: NSNotification.Name.updateCommunityFeed, object: nil)
////            NotificationCenter.default.post(name: NSNotification.Name.updateUserProfileFeed, object: nil)
//            self.dismiss(animated: true, completion: nil)
//        }
//        navigationController?.popViewController(animated: true)
    }
}

extension PostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        dismiss(animated: true, completion: nil)
        selectedImage = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension PostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if captionTextView.textColor == UIColor.lightGray {
            captionTextView.text = nil
            captionTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if captionTextView.text == "" {
            captionTextView.text = Localization.Forum.PlaceholderProblem.localized()
            captionTextView.textColor = UIColor.lightGray
        }
    }
}