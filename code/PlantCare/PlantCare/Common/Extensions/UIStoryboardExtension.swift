import Foundation
import UIKit

extension UIStoryboard {
    func instantiateVC<T: UIViewController>(_ viewControllerType: T.Type) -> T {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: viewControllerType)) as? T else {
            fatalError("Could not instantiateViewController with identifier: \(viewControllerType)")
        }
        return viewController
    }
}
