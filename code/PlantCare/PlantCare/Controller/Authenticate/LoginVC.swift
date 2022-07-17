import UIKit
import Firebase
import ProgressHUD

class LoginVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var forgotPassButton: UIButton!
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var registerLabel: UILabel!
    @IBOutlet private weak var emailErrorLabel: UILabel!
    @IBOutlet private weak var passwordErrorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        setupNavigationItem()
        setupTextField()
        setupButton()
        setupLabel()
    }
    
    private func setupNavigationItem() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Localization.Onboarding.Skip.localized(),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(skipBtnTap))
    }
    
    private func setupTextField() {
        CustomTextField.shared.styleTextField(
            textfield: emailTextField,
            placeholer: Localization.Authenticate.EmailPlaceHolder.localized(),
            icon: nil,
            underlineColor: AppColor.LightGrayColor)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        emailTextField.keyboardType = .emailAddress
        
        CustomTextField.shared.styleTextField(
            textfield: passwordTextField,
            placeholer: Localization.Authenticate.PasswordPlaceHolder.localized(),
            icon: AppImage.Icon.PrivatePassword,
            underlineColor: AppColor.LightGrayColor)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setupButton() {
        logInButton.setTitle(Localization.Authenticate.Login.localized(), for: .normal)
        logInButton.setTitleColor(AppColor.WhiteColor, for: .normal)
        logInButton.backgroundColor = AppColor.LightGrayColor
        logInButton.layer.cornerRadius = 20
        logInButton.isEnabled = false
        logInButton.addTarget(self, action: #selector(logInBtnTap), for: .touchUpInside)
        
        forgotPassButton.setTitle(Localization.Authenticate.ForgotPass.localized(), for: .normal)
        forgotPassButton.setTitleColor(AppColor.GreenColor, for: .normal)
        forgotPassButton.addTarget(self, action: #selector(forgotPasswordBtnTap), for: .touchUpInside)
        
        registerButton.setTitle(Localization.Authenticate.Register.localized(), for: .normal)
        registerButton.setTitleColor(AppColor.GreenColor, for: .normal)
        registerButton.addTarget(self, action: #selector(registerBtnTap), for: .touchUpInside)
    }
    
    private func setupLabel() {
        registerLabel.text = Localization.Authenticate.NoAccount.localized()
        registerLabel.textColor = AppColor.BlackColor
        
        emailErrorLabel.text = ""
        emailErrorLabel.textColor = AppColor.RedColor
        
        passwordErrorLabel.text = ""
        passwordErrorLabel.textColor = AppColor.RedColor
    }
}

// MARK: - Handle Actions
extension LoginVC {
    @objc private func logInBtnTap() {
        view.endEditing(true)
        ProgressHUD.show("Waiting...", interaction: false)
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        Auth.auth().logIn(email: email, password: password) { (err) in
            if err != nil {
                print("Error")
                return
            }
            let tabBarController = BaseTabBarController()
            UIApplication.shared.windows.first?.rootViewController = tabBarController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            UserDefaults.standard.set(
                EnumConstant.OnboardingStatus.Home.rawValue,
                forKey: NameConstant.UserDefaults.HasOnboarding)
            ProgressHUD.dismiss()
        }
        
//        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, err) in
//            if let err = err {
//                print("Failed to sign in with email:", err)
//                ProgressHUD.showError()
//                return
//            }
//            let tabBarController = BaseTabBarController()
//            UIApplication.shared.windows.first?.rootViewController = tabBarController
//            UIApplication.shared.windows.first?.makeKeyAndVisible()
//            UserDefaults.standard.set(
//                EnumConstant.OnboardingStatus.Home.rawValue,
//                forKey: NameConstant.UserDefaults.HasOnboarding)
//            ProgressHUD.dismiss()
//        })
    }
    
    @objc private func registerBtnTap() {
        let registerVC = UIStoryboard(name: NameConstant.Storyboard.Authenticate,
                                      bundle: nil).instantiateVC(RegisterVC.self)
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc private func forgotPasswordBtnTap() {
        let resetPasswordVC = UIStoryboard(name: NameConstant.Storyboard.Authenticate,
                                            bundle: nil).instantiateVC(ResetPasswordVC.self)
        navigationController?.pushViewController(resetPasswordVC, animated: true)
    }
    
    @objc private func textFieldDidChange() {
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
        
        if let emailInput = emailTextField.text,
           let passwordInput = passwordTextField.text,
           !emailInput.isEmpty, !passwordInput.isEmpty {
            logInButton.isEnabled = true
            logInButton.backgroundColor = AppColor.GreenColor
        } else {
            logInButton.isEnabled = false
            logInButton.backgroundColor = AppColor.LightGrayColor
        }
    }
    
    @objc private func skipBtnTap() {
        let tabBarController = BaseTabBarController()
        UIApplication.shared.windows.first?.rootViewController = tabBarController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        UserDefaults.standard.set(EnumConstant.OnboardingStatus.Home.rawValue,
                                  forKey: NameConstant.UserDefaults.HasOnboarding)
    }
}


// MARK: - Handle TextField Delegate
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
