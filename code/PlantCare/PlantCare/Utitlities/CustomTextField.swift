import Foundation
import UIKit

class CustomTextField {
    static let shared: CustomTextField = CustomTextField()
    
    func styleTextField(textfield: UITextField, placeholer: String?, icon: String?, underlineColor: UIColor?) {
        guard let placeholer = placeholer else {
            return
        }
        textfield.returnKeyType = .done
        textfield.backgroundColor = UIColor.clear
        textfield.tintColor = AppColor.BlackColor
        textfield.textColor = AppColor.BlackColor
        textfield.layer.masksToBounds = true
        textfield.borderStyle = .none
        textfield.placeholder = placeholer

        // Create the underline
        let underLine = CALayer()
        underLine.frame = CGRect(x: 0,
                                 y: textfield.frame.height - 5,
                                 width: textfield.frame.width,
                                 height: 1.2)
        guard let underlineColor = underlineColor else {
            return
        }
        underLine.backgroundColor = underlineColor.cgColor
        textfield.layer.addSublayer(underLine)
        
        if icon != nil {
            textfield.enablePasswordToggle()
        }
    }
    
    func searchTextField(textfield: UITextField, placeholder: String?, icon: String?) {
        if let placeholder = placeholder {
            textfield.placeholder = placeholder
        }
        textfield.leftViewMode = .always
        let container = UIView(frame: CGRect(x: 10,
                                             y: 2,
                                             width: 30,
                                             height: 30))
        let imageView = UIImageView(frame: CGRect(x: container.frame.minX,
                                                  y: container.frame.minY,
                                                  width: 25,
                                                  height: 25))
        if let icon = icon {
            let image = UIImage(named: icon)
            imageView.image = image
        }
        container.addSubview(imageView)
        textfield.leftView = container
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        
        
        
        
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
