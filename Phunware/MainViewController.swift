import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Moya
import AlamofireImage

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



class MainViewController: UIViewController {
  
  @IBOutlet var collectionView: UICollectionView!
  let provider = RxMoyaProvider<Phunware>()
  let things = Variable<[Thing]>([])
  
  override func viewDidLoad() {
    super.viewDidLoad()

    RxMoyaProvider<Phunware>().request(.starWars).mapJSON().map(Thing.from).subscribe(onNext: { self.things.value = $0 }).addDisposableTo(db)
    collectionView.backgroundColor = .white
    view.backgroundColor = .white
    
    (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: view.frame.width, height: 120)
    
    setupRx()
  }
  
  func setupRx() {
    
    things.asObservable().bindTo(collectionView!.rx.items(cellType: ThingCell.self)) { index, thing, cell in
      cell.thing = thing
      }.addDisposableTo(db)
//    collectionView!.rx.itemSelected.subscribe(onNext: { indexPath in
//      let thing = self.things.value[indexPath.row]
//      let dvc = DetailViewController()
//      dvc.thing = thing
//      let cell = self.collectionView?.cellForItem(at: indexPath) as! ThingCell
//      dvc.imageView.image = cell.imageView.image
//      self.show(dvc, sender: cell)
//    }).addDisposableTo(db)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let cell = sender as? ThingCell,
      let vc = segue.destination as? DetailViewController {
      vc.thing = cell.thing
    }
  }
  
  let db = DisposeBag()
}


class DetailViewController2: UIViewController {
  var thing: Thing! {
    didSet {
      dateLabel.text = thing.date
      locationLabel.text = thing.locationline2 + ", " + thing.locationline1
      descriptionLabel.text = thing.description
      titleLabel.text = thing.title
    }
  }
  
  let dateLabel: UILabel = {
    let l = UILabel()
    l.font = UIFont.systemFont(ofSize: 9)
    l.heroID = "date"
    l.heroModifiers = [.zPosition(4)]
    return l
  }()
  let titleLabel: UILabel = {
    let l = UILabel()
    l.font = UIFont.systemFont(ofSize: 9)
    l.heroID = "title"
    l.heroModifiers = [.zPosition(4)]
    return l
  }()
  let locationLabel: UILabel = {
    let l = UILabel()
    l.font = UIFont.systemFont(ofSize: 9)
    l.heroID = "location"
    l.heroModifiers = [.zPosition(4)]
    return l
  }()
  
  let descriptionLabel: UILabel = {
    let l = UILabel()
    l.font = UIFont.systemFont(ofSize: 9)
    l.numberOfLines = 0
    l.heroID = "description"
    l.heroModifiers = [.zPosition(4)]
    return l
  }()
  
  let imageView: UIImageView = {
    let i = UIImageView()
    i.heroID = "image"
    i.heroModifiers = [.zPosition(2)]
    return i
  }()
  
  init() {
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .white
    
    [imageView, dateLabel,titleLabel,locationLabel,descriptionLabel].forEach { view.addSubview($0) }
    
    imageView.snp.makeConstraints { make in
      make.top.equalTo(view).offset(10)
      make.left.equalToSuperview().offset(10)
      make.right.equalToSuperview().offset(10)
    }
    dateLabel.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(10)
      make.left.equalToSuperview().offset(10)
      make.right.equalToSuperview().offset(10)
    }
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(dateLabel.snp.bottom).offset(10)
      make.left.equalToSuperview().offset(10)
      make.right.equalToSuperview().offset(10)
    }
    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(10)
      make.left.equalToSuperview().offset(10)
      make.right.equalToSuperview().offset(10)
    }
    isHeroEnabled = true
  }
  
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
}



class DetailViewController: UIViewController {
  var thing: Thing!
  
  @IBOutlet weak var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageView.heroID = "imageView"
  }
}
















