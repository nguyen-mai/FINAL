import Foundation
import UIKit

extension UITextField {
    func enablePasswordToggle(){
        self.rightViewMode = .always
        self.isSecureTextEntry = true
        let button = UIButton(frame: CGRect(x: 0,
                                         y: 0,
                                         width: 20,
                                         height: 20))
        let container = UIView(frame: CGRect(x: 20,
                                             y: 0,
                                             width: 30,
                                             height: 30))
        container.addSubview(button)
        self.rightView = container
        setPasswordToggleImage(button)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
    }
    
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.setImage(UIImage(named: AppImage.Icon.PrivatePassword), for: .normal)
        }else{
            button.setImage(UIImage(named: AppImage.Icon.PublicPassword), for: .normal)

        }
    }

    @objc
    private func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}
