import UIKit
import Firebase
import ProgressHUD

class RegisterVC: UIViewController {
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var createAccountLabel: UILabel!
    @IBOutlet private weak var loginLabel: UILabel!
    
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var logInButton: UIButton!
    
    @IBOutlet private weak var emailErrorLabel: UILabel!
    @IBOutlet private weak var passwordErrorLabel: UILabel!
    @IBOutlet private weak var passInfoLabel: UILabel!
    @IBOutlet private weak var userNameErrrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() {
        setupLabel()
        setupTextField()
        setupButton()
        setupNavigationItem()
        ProgressHub.shared.setupProgressHub()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleKeyBoard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setupNavigationItem() {
        backButton.setImage(UIImage(named: AppImage.Icon.Back)?.withTintColor(AppColor.GreenColor!), for: .normal)
        backButton.addTarget(self, action: #selector(backBtnTap), for: .touchUpInside)
    }
    
    private func setupLabel() {
        createAccountLabel.text = Localization.Authenticate.CreateAccount.localized()
        createAccountLabel.textColor = AppColor.BlackColor
        
        loginLabel.text = Localization.Authenticate.AlreadyAccount.localized()
        loginLabel.textColor = AppColor.BlackColor
        
        emailErrorLabel.text = Localization.Authenticate.EmptyErrorTF.localized()
        emailErrorLabel.textColor = AppColor.RedColor
        
        passwordErrorLabel.text = Localization.Authenticate.EmptyErrorTF.localized()
        passwordErrorLabel.textColor = AppColor.RedColor
        
        userNameErrrorLabel.text = Localization.Authenticate.EmptyErrorTF.localized()
        userNameErrrorLabel.textColor = AppColor.RedColor
        
        passInfoLabel.text = Localization.Authenticate.RequirementPassword.localized()
        passInfoLabel.textColor = AppColor.GrayColor
        
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        userNameErrrorLabel.isHidden = true
    }
    
    private func setupTextField() {
        CustomTextField.shared.styleTextField(
            textfield: userNameTextField,
            placeholer: Localization.Authenticate.UsernamePlaceholder.localized(),
            icon: nil,
            underlineColor: AppColor.LightGrayColor)
        userNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        CustomTextField.shared.styleTextField(
            textfield: emailTextField,
            placeholer: Localization.Authenticate.EmailPlaceHolder.localized(),
            icon: nil,
            underlineColor: AppColor.LightGrayColor)
        emailTextField.keyboardType = .emailAddress
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        CustomTextField.shared.styleTextField(
            textfield: passwordTextField,
            placeholer: Localization.Authenticate.PasswordPlaceHolder.localized(),
            icon: AppImage.Icon.PrivatePassword,
            underlineColor: AppColor.LightGrayColor)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupButton() {
        registerButton.setTitle(Localization.Authenticate.Register.localized(), for: .normal)
        registerButton.setTitleColor(AppColor.WhiteColor, for: .normal)
        registerButton.backgroundColor = AppColor.LightGrayColor
        registerButton.layer.cornerRadius = 20
        registerButton.addTarget(self, action: #selector(registerBtnTap), for: .touchUpInside)
        
        logInButton.setTitle(Localization.Authenticate.Login.localized(), for: .normal)
        logInButton.setTitleColor(AppColor.GreenColor, for: .normal)
        logInButton.addTarget(self, action: #selector(logInBtnTap), for: .touchUpInside)
    }
}

// MARK: - Handle Actions
extension RegisterVC {
    @objc private func handleKeyBoard(_ tap: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc private func backBtnTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func registerBtnTap() {
        view.endEditing(true)
        guard let email = emailTextField.text,
              let username = userNameTextField.text,
              let password = passwordTextField.text else {
                  return
              }
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if CustomTextField.isPasswordValid(cleanedPassword) == false {
            ProgressHUD.showError(Localization.Authenticate.ErrorRequirementPassword.localized())
        } else {
            ProgressHUD.show()
            Auth.auth().createUser(withEmail: email, username: username, password: password, image: nil) { (err) in
                if let err = err {
                    ProgressHUD.showError(err.localizedDescription.localized())
                    return
                }
                ProgressHUD.dismiss()
                self.showLogInAlert()
            }
        }
    }
    
    private func showLogInAlert() {
        let alert = UIAlertController(title: Localization.Alert.Congrat.localized(),
                                      message: Localization.Alert.RegisterSuccessfully.localized(),
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: Localization.Alert.GoLogIn.localized(),
            style: .default) { _ in
            let vc = UIStoryboard(name: NameConstant.Storyboard.Authenticate,
                                  bundle: nil).instantiateVC(LoginVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        let cancelAction = UIAlertAction(
            title: Localization.Alert.Cancel.localized(),
            style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func logInBtnTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textFieldDidChange() {
        if let usernameInput = userNameTextField.text, !usernameInput.isEmpty {
            CustomTextField.shared.styleTextField(
                textfield: userNameTextField,
                placeholer: Localization.Authenticate.UsernamePlaceholder.localized(),
                icon: nil,
                underlineColor: AppColor.GreenColor)
        } else {
            CustomTextField.shared.styleTextField(
                textfield: userNameTextField,
                placeholer: Localization.Authenticate.UsernamePlaceholder.localized(),
                icon: nil,
                underlineColor: AppColor.LightGrayColor)
        }
        
        if let emailInput = emailTextField.text, !emailInput.isEmpty {
            CustomTextField.shared.styleTextField(
                textfield: emailTextField,
                placeholer: Localization.Authenticate.EmailPlaceHolder.localized(),
                icon: nil,
                underlineColor: AppColor.GreenColor)
        } else {
            CustomTextField.shared.styleTextField(
                textfield: emailTextField,
                placeholer: Localization.Authenticate.EmailPlaceHolder.localized(),
                icon: nil,
                underlineColor: AppColor.LightGrayColor)
        }
        
        if let passwordInput = passwordTextField.text, !passwordInput.isEmpty {
            CustomTextField.shared.styleTextField(
                textfield: passwordTextField,
                placeholer: Localization.Authenticate.PasswordPlaceHolder.localized(),
                icon: AppImage.Icon.PrivatePassword,
                underlineColor: AppColor.GreenColor)
        } else {
            CustomTextField.shared.styleTextField(
                textfield: passwordTextField,
                placeholer: Localization.Authenticate.PasswordPlaceHolder.localized(),
                icon: AppImage.Icon.PrivatePassword,
                underlineColor: AppColor.LightGrayColor)
        }
        
        if let userNameInput = userNameTextField.text,
           let emailInput = emailTextField.text,
           let passwordInput = passwordTextField.text,
           !userNameInput.isEmpty,
           !emailInput.isEmpty,
           !passwordInput.isEmpty {
            registerButton.backgroundColor = AppColor.GreenColor
        } else {
            registerButton.backgroundColor = AppColor.LightGrayColor
        }
    }
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
