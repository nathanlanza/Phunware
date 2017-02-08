import UIKit
import Hero

class DetailCell: UITableViewCell {
  
  func configure(for thing: Thing) {
    dateLabel.text = thing.date
    titleLabel.text = thing.title
    locationLabel.text = thing.locationline2 + ", " + thing.locationline1
    descriptionLabel.text = thing.description
  }
  let dateLabel: UILabel = {
    let l = UILabel()
    l.font = UIFont.systemFont(ofSize: 14)
    l.heroID = "date"
        l.heroModifiers = [.zPosition(3)]
    return l
  }()
  let titleLabel: UILabel = {
    let l = UILabel()
    l.font = UIFont.systemFont(ofSize: 25)
    l.heroID = "title"
        l.heroModifiers = [.zPosition(3)]
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
    l.font = UIFont.systemFont(ofSize: 19)
    l.numberOfLines = 0
    l.heroID = "description"
    l.heroModifiers = [.zPosition(3)]
    return l
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    [dateLabel,titleLabel,locationLabel,descriptionLabel].forEach { contentView.addSubview($0) }
    
    dateLabel.snp.makeConstraints { make in
      make.top.equalTo(contentView.snp.top).offset(10)
      make.left.equalToSuperview().offset(10)
      make.right.lessThanOrEqualToSuperview().offset(-10)
    }
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(dateLabel.snp.bottom).offset(10)
      make.left.equalToSuperview().offset(10)
      make.right.lessThanOrEqualToSuperview().offset(-10)
    }
    descriptionLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(10)
      make.left.equalToSuperview().offset(10)
      make.right.lessThanOrEqualToSuperview().offset(-10)
      make.bottom.equalTo(contentView.snp.bottom).offset(-10)
    }
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError() }
}
