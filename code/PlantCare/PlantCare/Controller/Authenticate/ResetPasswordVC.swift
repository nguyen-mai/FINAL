import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet private weak var resetPassTitleLabel: UILabel!
    @IBOutlet private weak var resetPassSubTitleLabel: UILabel!
    @IBOutlet private weak var emailErrorLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var sendButton: UIButton!
    
    
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
    @objc
    private func sendBtnTap() {
        
    }
    
    @objc
    private func textFieldDidChange() {
        if let emailInput = emailTextField.text, !emailInput.isEmpty {
            CustomTextField.shared.styleTextField(
                textfield: emailTextField,
                placeholer: Localization.Authenticate.EmailPlaceHolder,
                icon: nil,
                underlineColor: AppColor.GreenColor)
            sendButton.isEnabled = true
            sendButton.backgroundColor = AppColor.GreenColor
        } else {
            CustomTextField.shared.styleTextField(
                textfield: emailTextField,
                placeholer: Localization.Authenticate.EmailPlaceHolder,
                icon: nil,
                underlineColor: AppColor.LightGrayColor)
            sendButton.isEnabled = false
            sendButton.backgroundColor = AppColor.LightGrayColor
        }
    }
}
