import UIKit
import Firebase

class ResetPasswordVC: UIViewController {
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var resetPassTitleLabel: UILabel!
    @IBOutlet private weak var resetPassSubTitleLabel: UILabel!
    @IBOutlet private weak var emailErrorLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupUI() {
        setupLabel()
        setupTextField()
        setupButton()
        setupNavigationItem()
    }
    
    private func setupNavigationItem() {
        backButton.setImage(UIImage(named: AppImage.Icon.Back)?.withTintColor(AppColor.GreenColor!), for: .normal)
        backButton.addTarget(self, action: #selector(backBtnTap), for: .touchUpInside)
    }
    
    private func setupLabel() {
        resetPassTitleLabel.text = Localization.Authenticate.ResetPassTitle.localized()
        resetPassTitleLabel.textColor = AppColor.BlackColor
        
        resetPassSubTitleLabel.text = Localization.Authenticate.ResetPassInfo.localized()
        resetPassSubTitleLabel.textColor = AppColor.LightGrayColor
        
        emailErrorLabel.text = ""
        emailErrorLabel.textColor = AppColor.RedColor
    }
    
    private func setupTextField() {
        CustomTextField.shared.styleTextField(
            textfield: emailTextField,
            placeholer: Localization.Authenticate.EmailPlaceHolder,
            icon: nil,
            underlineColor: AppColor.LightGrayColor)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        emailTextField.delegate = self
    }
    
    private func setupButton() {
        sendButton.setTitle(Localization.Authenticate.Send, for: .normal)
        sendButton.setTitleColor(AppColor.WhiteColor, for: .normal)
        sendButton.backgroundColor = AppColor.LightGrayColor
        sendButton.isEnabled = false
        sendButton.layer.cornerRadius = 20
        sendButton.addTarget(self, action: #selector(sendBtnTap), for: .touchUpInside)
    }
}

// MARK: - Handle Actions
extension ResetPasswordVC {
    @objc private func backBtnTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func sendBtnTap() {
        guard let email = emailTextField.text else {
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print(error.localizedDescription)
                self.showAlert(title: Localization.Alert.Sorry.localized(),
                               message: "\(error.localizedDescription)")
            }
            self.showAlert(title: Localization.Alert.Congrat.localized(),
                           message: Localization.Alert.ResetEmail.localized())
        }
    }
    
    private func showAlert(title: String?, message: String?) {
        guard let title = title,
              let message = message else {
            return
        }
        let alert = UIAlertController(title: title.localized(),
                                      message: message.localized(),
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: Localization.Alert.OK, style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    private func textFieldDidChange() {
        if let emailInput = emailTextField.text, !emailInput.isEmpty {
            CustomTextField.shared.styleTextField(
                textfield: emailTextField,
                placeholer: Localization.Authenticate.EmailPlaceHolder.localized(),
                icon: nil,
                underlineColor: AppColor.GreenColor)
            sendButton.isEnabled = true
            sendButton.backgroundColor = AppColor.GreenColor
        } else {
            CustomTextField.shared.styleTextField(
                textfield: emailTextField,
                placeholer: Localization.Authenticate.EmailPlaceHolder.localized(),
                icon: nil,
                underlineColor: AppColor.LightGrayColor)
            sendButton.isEnabled = false
            sendButton.backgroundColor = AppColor.LightGrayColor
        }
    }
}

extension ResetPasswordVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        return true
    }
}
