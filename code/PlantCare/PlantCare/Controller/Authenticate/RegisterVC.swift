import UIKit
import Firebase
import ProgressHUD

class RegisterVC: UIViewController {
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupLabel() {
        createAccountLabel.text = Localization.Authenticate.CreateAccount.localized()
        createAccountLabel.textColor = AppColor.BlackColor
        
        loginLabel.text = Localization.Authenticate.AlreadyAccount.localized()
        loginLabel.textColor = AppColor.BlackColor
        
        emailErrorLabel.text = Localization.Authenticate.EmptyErrorTF
        emailErrorLabel.textColor = AppColor.RedColor
        
        passwordErrorLabel.text = Localization.Authenticate.EmptyErrorTF
        passwordErrorLabel.textColor = AppColor.RedColor
        
        userNameErrrorLabel.text = Localization.Authenticate.EmptyErrorTF
        userNameErrrorLabel.textColor = AppColor.RedColor
        
        passInfoLabel.text = Localization.Authenticate.RequirementPassword
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
        
        logInButton.setTitle(Localization.Authenticate.Login, for: .normal)
        logInButton.setTitleColor(AppColor.GreenColor, for: .normal)
        logInButton.addTarget(self, action: #selector(logInBtnTap), for: .touchUpInside)
    }
}

// MARK: - Handle Actions
extension RegisterVC {
    @objc private func registerBtnTap() {
        view.endEditing(true)
        guard let email = emailTextField.text,
              let username = userNameTextField.text,
              let password = passwordTextField.text else {
                  return
              }
        ProgressHUD.show("Waiting...", interaction: false)
        Auth.auth().createUser(withEmail: email, username: username, password: password, image: nil) { (err) in
            ProgressHUD.dismiss()
            if err != nil {
                print("Error")
                return
            }
            self.showAlert(title: Localization.Alert.Congrat)
        }
    }
    
    private func showAlert(title: String) {
        let alert = UIAlertController(title: title,
                                      message: Localization.Alert.RegisterSuccessfully,
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
