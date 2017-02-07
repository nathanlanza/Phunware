import UIKit
import SnapKit
import Hero

class ThingCell: UICollectionViewCell {
  
  let dateLabel: UILabel = {
    let l = UILabel()
    l.font = UIFont.systemFont(ofSize: 9)
//    l.heroID = "date"
    return l
  }()
  let titleLabel: UILabel = {
    let l = UILabel()
    l.font = UIFont.systemFont(ofSize: 9)
//    l.heroID = "title"
    return l
  }()
  let locationLabel: UILabel = {
    let l = UILabel()
    l.font = UIFont.systemFont(ofSize: 9)
//    l.heroID = "location"
    return l
  }()
  
  let descriptionLabel: UILabel = {
    let l = UILabel()
    l.font = UIFont.systemFont(ofSize: 9)
    l.numberOfLines = 0
//    l.heroID = "description"
    return l
  }()
  
  let imageView: UIImageView = {
    let i = UIImageView()
//    i.heroID = "image"
    return i
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    
    [dateLabel,titleLabel,locationLabel,descriptionLabel].forEach { self.contentView.addSubview($0) }     

    dateLabel.snp.makeConstraints { make in
      make.top.equalTo(dateLabel.superview!).offset(20)
      make.left.equalTo(dateLabel.superview!).offset(20)
    }
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(dateLabel.snp.bottom).offset(10)
      make.left.equalTo(titleLabel.superview!).offset(20)
    }
    locationLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(10)
      make.left.equalTo(locationLabel.superview!).offset(20)
    }
    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(locationLabel.snp.bottom).offset(10)
      make.left.equalTo(descriptionLabel.superview!).offset(20)
      make.bottom.equalTo(descriptionLabel.superview!).offset(-20)
      make.right.equalTo(descriptionLabel.superview!).offset(-20)
    }

    backgroundView = imageView
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
  
  func configure(for thing: Thing) {
    dateLabel.text = thing.date
    titleLabel.text = thing.title
    locationLabel.text = "\(thing.locationline2), \(thing.locationline1)"
    descriptionLabel.text = thing.description
    imageView.af_setImage(withURL: URL(string: thing.image)!)
  }
  
}
