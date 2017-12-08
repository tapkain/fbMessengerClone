//
//  ViewController.swift
//  FacebookMessenger
//
//  Created by Yevhen Velizhenkov on 12/8/17.
//  Copyright © 2017 Yevhen Velizhenkov. All rights reserved.
//

import UIKit

class FriendsViewController: UICollectionViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Recent"
    
    collectionView?.backgroundColor = UIColor.white
    collectionView?.alwaysBounceVertical = true
    
    collectionView?.register(FriendCell.self, forCellWithReuseIdentifier: FriendCell.identifier)
  }
}

extension FriendsViewController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: FriendCell.identifier, for: indexPath)
  }
}

extension FriendsViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: 100)
  }
}

class FriendCell: UICollectionViewCell {
  static let identifier = String(describing: FriendCell.self)
  
  let profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 34
    imageView.layer.masksToBounds = true
    return imageView
  }()
  
  let separatorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
    return view
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.text = "Friend Name"
    label.font = UIFont.systemFont(ofSize: 18)
    return label
  }()
  
  let messageLabel: UILabel = {
    let label = UILabel()
    label.text = "Message"
    label.textColor = UIColor.gray
    label.font = UIFont.systemFont(ofSize: 14)
    return label
  }()
  
  let timeLabel: UILabel = {
    let label = UILabel()
    label.text = "12:35 pm"
    label.font = UIFont.systemFont(ofSize: 16)
    label.textAlignment = .right
    return label
  }()
  
  let hasReadImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 10
    imageView.layer.masksToBounds = true
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func setupViews() {
    setupContainerView()
    
    addSubview(profileImageView)
    addSubview(separatorView)
    
    profileImageView.image = UIImage(named: "profile")
    hasReadImageView.image = UIImage(named: "profile")
    
    addConstraintsWithFormat(format: "V:[v0(68)]", views: profileImageView)
    addConstraintsWithFormat(format: "H:|-12-[v0(68)]", views: profileImageView)
    profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    addConstraintsWithFormat(format: "H:|-82-[v0]|", views: separatorView)
    addConstraintsWithFormat(format: "V:[v0(1)]|", views: separatorView)
  }
  
  private func setupContainerView() {
    let containerView = UIView()
    
    addSubview(containerView)
    addConstraintsWithFormat(format: "V:[v0(50)]", views: containerView)
    addConstraintsWithFormat(format: "H:|-90-[v0]|", views: containerView)
    containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    containerView.addSubview(nameLabel)
    containerView.addSubview(messageLabel)
    containerView.addSubview(timeLabel)
    containerView.addSubview(hasReadImageView)
    
    containerView.addConstraintsWithFormat(format: "H:|[v0][v1(80)]-12-|", views: nameLabel, timeLabel)
    containerView.addConstraintsWithFormat(format: "V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
    containerView.addConstraintsWithFormat(format: "H:|[v0]-8-[v1(20)]-12-|", views: messageLabel, hasReadImageView)
    containerView.addConstraintsWithFormat(format: "V:[v0(20)]|", views: hasReadImageView)
    containerView.addConstraintsWithFormat(format: "V:|[v0(24)]", views: timeLabel)
  }
}

extension UIView {
  func addConstraintsWithFormat(format: String, views: UIView...) {
    var viewsDictionary = [String: UIView]()
    
    for (index, view) in views.enumerated() {
      let key = "v\(index)"
      viewsDictionary[key] = view
      view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
  }
}
