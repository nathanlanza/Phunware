import UIKit
import Hero
import GSKStretchyHeaderView
import SnapKit

class DetailViewController: UIViewController {
  var thing: Thing!
  let imageView: UIImageView = {
    let i = UIImageView()
    i.heroID = "image"
    return i
  }()
  
  let tableView = UITableView()
  func setupTV() {
    view.addSubview(tableView)
    tableView.tableFooterView = UIView()
    tableView.separatorStyle = .none
    
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }

    header = StretchingHeader(imageView: imageView, size: CGSize(width: view.frame.width, height: 200), vc: self, behavior: .overNav)
    tableView.tableHeaderView = header
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  var header: StretchingHeader!


  override func viewDidLoad() {
    super.viewDidLoad()

    setupTV()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    print(tableView.contentInset)
  }
  
  init() {
    super.init(nibName: nil, bundle: nil)
    view.backgroundColor = .white

    isHeroEnabled = true
  }
  
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
}

extension DetailViewController: UIScrollViewDelegate, UITableViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    header.update(scrollView: scrollView)
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 200
  }
}
extension DetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = DetailCell(style: .default, reuseIdentifier: "cell")
    cell.configure(for: thing)
    return cell
  }
}

