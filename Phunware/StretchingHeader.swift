import UIKit

class StretchingHeader: UIView {
  
  enum Behavior {
    case overNav
    case underNav
  }
  
  let imageView: UIImageView
  let contentSize: CGSize
  var behavior: Behavior!
  
  init(imageView: UIImageView, size: CGSize, vc: UIViewController, behavior: Behavior) {
    
    self.imageView = imageView
    self.contentSize = CGSize(width: size.width * (1 + scale), height: size.height * (1 + scale))
    
    super.init(frame: .zero)
    
//    guard let tableView = (vc.view.subviews.filter { $0 is UITableView }).first as? UITableView else { fatalError("View controller must contain a tableView") }
    
//    (tableView as UIScrollView).panGestureRecognizer.addTarget(self, action: Selector("update()"))
    

    addSubview(imageView)
    
//    layer.borderColor = UIColor.blue.cgColor
//    layer.borderWidth = 2
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.isUserInteractionEnabled = true
    
    offset = UIApplication.shared.statusBarFrame.height + (vc.navigationController?.navigationBar.frame.size.height ?? 44)
    
    //    switch behavior {
    //    case .overNav:
    //      vc.automaticallyAdjustsScrollViewInsets = false
    //    case .underNav:
    //      if let translucent = vc.navigationController?.navigationBar.isTranslucent, translucent {
    //        topInset += statusBarHeight + navigationBarHeight
    //      }
    //    }
    
    imageView.frame = CGRect(x: -size.width * (scale/2) , y: -size.height * scale, width: contentSize.width, height: contentSize.height )
    frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
  }
  
  var offset: CGFloat = 0
  let scale: CGFloat = 0.6
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  
  func update(scrollView: UIScrollView) {
    var scrollOffset = scrollView.contentOffset.y
    scrollOffset += offset
    print(scrollOffset)
    
    let s = (contentSize.height - scrollOffset) / (contentSize.height)
    if scrollOffset < contentSize.height * (scale/(1+scale)) {
      imageView.transform = CGAffineTransform(translationX: 0, y: scrollOffset/2).scaledBy(x: s, y: s)
    }
  }
}
