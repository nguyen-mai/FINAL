import Foundation
import UIKit

extension UIColor {
    
    static let tabBarColor = UIColor(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 0.5)
    static let greenColor = UIColor(red: 0.0/255.0, green: 163.0/255.0, blue: 128.0/255.0, alpha: 1)
    static let darkGreenColor = UIColor(red: 57.0/255.0, green: 103.0/255.0, blue: 91.0/255.0, alpha: 1.0)
    static let lightGrayColor = UIColor(red: 242.0/255.0, green: 247.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    static let darkGrayColor = UIColor(white: 0, alpha: 0.6)
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
