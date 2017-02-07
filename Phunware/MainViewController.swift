import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Moya

class MainViewController: CollectionViewController<ThingCell> {
    
    let provider = RxMoyaProvider<Phunware>()
    
    override func setupLayout() {
        super.setupLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 120)
    }
    override func setupRx() {
        super.setupRx()
        getThings().bindTo(collectionView!.rx.items(cellIdentifier: "cell", cellType: ThingCell.self)) { index, thing, cell in
            cell.configure(for: thing)
            }.addDisposableTo(db)
        collectionView!.rx.modelSelected(Thing.self).subscribe(onNext: { thing in
            let dvc = DetailViewController()
            dvc.thing = thing
            dvc.useLayoutToLayoutNavigationTransitions = true
            self.show(dvc, sender: self)
        }).addDisposableTo(db)
    }
    
    func getThings() -> Observable<[Thing]> {
        return provider.request(.starWars).mapJSON().map(Thing.from)
    }
}
class CollectionViewController<Cell: UICollectionViewCell>: UICollectionViewController {
    var layout: UICollectionViewFlowLayout { return collectionViewLayout as! UICollectionViewFlowLayout }
    func setupLayout() {

    }
    func setupRx() {
        collectionView?.delegate = nil
        collectionView?.dataSource = nil
        collectionView!.register(Cell.self, forCellWithReuseIdentifier: "cell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupRx()
    }
    let db = DisposeBag()
}


class DetailViewController: CollectionViewController<UICollectionViewCell> {
    var thing: Thing!
    override func setupLayout() {
        super.setupLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
    }
    override func setupRx() {
        super.setupRx()
        Observable.just([thing]).bindTo(collectionView!.rx.items(cellIdentifier: "cell", cellType: UICollectionViewCell.self)) { index, thing, cell in
            cell.backgroundColor = .red
        }.addDisposableTo(db)
    }

}
