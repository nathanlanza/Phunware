import RxSwift
import UIKit
import RxCocoa

extension Reactive where Base: UICollectionView {
  func items<S: Sequence, Cell: UICollectionViewCell, O : ObservableType>
    (cellType: Cell.Type = Cell.self)
    -> (_ source: O)
    -> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
    -> Disposable
    where O.E == S, Cell: Reusable {
      return items(cellIdentifier: cellType.reuseIdentifier, cellType: cellType)
  }
}
