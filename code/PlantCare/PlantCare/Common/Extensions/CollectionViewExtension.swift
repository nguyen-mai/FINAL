import UIKit

extension UICollectionView {
    func registerCellNib<T: UICollectionViewCell>(type cell: T.Type) {
        let nib = UINib(nibName: "\(cell.self)", bundle: nil)
        register(nib, forCellWithReuseIdentifier: "\(cell.self)")
    }
    
    func dequeueReusableCellNib<T: UICollectionViewCell>(type cell: T.Type, for indexPath: IndexPath) -> T? {
        guard let cell = dequeueReusableCell(withReuseIdentifier: "\(cell.self)", for: indexPath) as? T else {
            Logger.error("Could not dequeue cell with identifier: \(cell.self)")
            return nil
        }
        return cell
    }
}

