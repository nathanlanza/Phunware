import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Moya
import AlamofireImage

class MainViewController: UIViewController {
  
  var collectionView: UICollectionView!
  let layout = UICollectionViewFlowLayout()
  
  let provider = RxMoyaProvider<Phunware>()
  let things = Variable<[Thing]>([])
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    setupCV()
    setupLayout()
    setupRx()
    
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
  }
  
  func setupCV() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    view.addSubview(collectionView)
    
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    collectionView.register(ThingCell.self)
  }
  
  func setupLayout() {
    layout.itemSize = CGSize(width: view.frame.width, height: 120)
    layout.minimumLineSpacing = 0
  }
  
  func setupRx() {
    RxMoyaProvider<Phunware>().request(.starWars).mapJSON().map(Thing.from).subscribe(onNext: { self.things.value = $0 }).addDisposableTo(db)
    things.asObservable().bindTo(collectionView!.rx.items(cellType: ThingCell.self)) { index, thing, cell in
      cell.configure(for: thing)
      }.addDisposableTo(db)
    collectionView!.rx.itemSelected.subscribe(onNext: { indexPath in
      let thing = self.things.value[indexPath.row]
      let dvc = DetailViewController()
      dvc.thing = thing
      let cell = self.collectionView?.cellForItem(at: indexPath) as! ThingCell
      self.selectedCell = cell
      dvc.imageView.image = cell.imageView.image
      cell.dateLabel.heroID = "date"
      cell.titleLabel.heroID = "title"
      cell.locationLabel.heroID = "location"
      cell.descriptionLabel.heroID = "description"
      cell.imageView.heroID = "image"
      self.show(dvc, sender: cell)
    }).addDisposableTo(db)
  }
  
  weak var selectedCell: ThingCell?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    navigationController?.navigationBar.shadowImage = nil
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear (animated)
    if let cell = selectedCell {
      cell.dateLabel.heroID = ""
      cell.titleLabel.heroID = ""
      cell.locationLabel.heroID = ""
      cell.descriptionLabel.heroID = ""
      cell.imageView.heroID = ""
    }
    print(collectionView.contentInset)
  }
  

  let db = DisposeBag()
}




















