import UIKit
import Firebase
import ProgressHUD

class RegisterVC: UIViewController {
    
    @IBOutlet private weak var createAccountLabel: UILabel!
    @IBOutlet private weak var loginLabel: UILabel!
    
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var logInButton: UIButton!
    
    @IBOutlet private weak var emailErrorLabel: UILabel!
    @IBOutlet private weak var passwordErrorLabel: UILabel!
    @IBOutlet private weak var confirmPassErrorLabel: UILabel!
    @IBOutlet private weak var passInfoLabel: UILabel!
    
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
    
    private func setupLabel() {
        createAccountLabel.text = Localization.Authenticate.CreateAccount.localized()
        createAccountLabel.textColor = AppColor.BlackColor
        
        loginLabel.text = Localization.Authenticate.AlreadyAccount.localized()
        loginLabel.textColor = AppColor.BlackColor
        
        emailErrorLabel.text = ""
        emailErrorLabel.textColor = AppColor.RedColor
        
        passwordErrorLabel.text = ""
        passwordErrorLabel.textColor = AppColor.RedColor
        
        confirmPassErrorLabel.text = ""
        confirmPassErrorLabel.textColor = AppColor.RedColor
        
        passInfoLabel.text = Localization.Authenticate.RequirementPassword
        passInfoLabel.textColor = AppColor.GrayColor
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
        
        CustomTextField.shared.styleTextField(
            textfield: confirmPasswordTextField,
            placeholer: Localization.Authenticate.ConfirmPassword.localized(),
            icon: AppImage.Icon.PrivatePassword,
            underlineColor: AppColor.LightGrayColor)
        confirmPasswordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        confirmPasswordTextField.delegate = self
    }
    
    private func setupButton() {
        registerButton.setTitle(Localization.Authenticate.Register.localized(), for: .normal)
        registerButton.setTitleColor(AppColor.WhiteColor, for: .normal)
        registerButton.backgroundColor = AppColor.LightGrayColor
        registerButton.isEnabled = false
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
        ProgressHUD.show("Waiting...", interaction: false)
        guard let userName = userNameTextField.text,let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        Auth.auth().createUser(withEmail: email, username: userName, password: password, image: nil) { (err) in
            if err != nil {
                print("Error")
                return
            }
            ProgressHUD.dismiss()
            self.showAlert()
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: Localization.Alert.Congrat,
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
        if let userNameInput = userNameTextField.text, !userNameInput.isEmpty {
            
        } else {
            
        }
        
        if let emailInput = emailTextField.text, !emailInput.isEmpty {
            
        } else {
            
        }
        
        if let passwordInput = passwordTextField.text, !passwordInput.isEmpty {
            
        } else {
            
        }
        
        if let confirmPassInput = confirmPasswordTextField.text, !confirmPassInput.isEmpty {
            
        } else {
            
        }
        
        if let userNameInput = userNameTextField.text,
           let emailInput = emailTextField.text,
           let passwordInput = passwordTextField.text,
           let confirmPassInput = confirmPasswordTextField.text,
           !userNameInput.isEmpty,
           !emailInput.isEmpty,
           !passwordInput.isEmpty,
           !confirmPassInput.isEmpty,
           passwordInput == confirmPassInput {
            registerButton.isEnabled = true
            registerButton.backgroundColor = AppColor.GreenColor
        } else {
            registerButton.isEnabled = false
            registerButton.backgroundColor = AppColor.LightGrayColor
        }
    }
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        confirmPasswordTextField.resignFirstResponder()
        return true
    }
}
