import UIKit

protocol Reusable {}
extension Reusable {
  static var reuseIdentifier: String { return String(describing: self) }
}
extension UICollectionViewCell: Reusable {}

extension UICollectionView {
  func register<T: UICollectionViewCell>(_ cellClass: T.Type) where T: Reusable {
    register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
  }
}
extension UICollectionView {
  func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: Reusable {
    return dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
  }
}
