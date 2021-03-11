//
//  RepositoryCell.swift
//  Swift-MVP-No-Storyboard
//
//  Created by Chamath Jeevan on 2021-03-09.
//

import Foundation
import UIKit

class RepositoryCell: UICollectionViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true;
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(displayP3Red: 204/255, green: 204/255, blue: 204/255, alpha: 1).cgColor
        return view
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Avatar")
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label =   UILabel()
        label.font = UIFont(name:"SourceSansPro-Regular", size: 16.0)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label =   UILabel()
        label.font = UIFont(name:"SourceSansPro-Bold", size: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label =   UILabel()
        label.font = UIFont(name:"SourceSansPro-Regular", size: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starImage: UIImageView = {
        let image =   UIImageView()
        image.image = UIImage(named: "Star")
        image.contentMode = UIView.ContentMode.scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let starCountLabel: UILabel = {
        let label =   UILabel()
        label.font = UIFont(name:"SourceSansPro-Regular", size: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ovalImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Oval")
        image.contentMode = UIView.ContentMode.scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"SourceSansPro-Regular", size: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
    }
    
    func addViews(){
        
        addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        
        containerView.addSubview(profileImage)
        
        containerView.addConstraint(NSLayoutConstraint(item: profileImage, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 16))
        containerView.addConstraint(NSLayoutConstraint(item: profileImage, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 16))
        profileImage.addConstraint(NSLayoutConstraint(item: profileImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 32))
        profileImage.addConstraint(NSLayoutConstraint(item: profileImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 32))
        containerView.addSubview(nameLabel)
        nameLabel.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 24))
        containerView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 20))
        containerView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: profileImage, attribute: .trailing, multiplier: 1, constant: 7))
        
        containerView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -5))
        
        containerView.addSubview(titleLabel)
        
        titleLabel.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 24))
        containerView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: profileImage, attribute: .bottom, multiplier: 1, constant: 4))
        containerView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 16))
        containerView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -5))
        
        containerView.addSubview(descriptionLabel)
        descriptionLabel.addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 24))
        containerView.addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 16))
        containerView.addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -5))
        
        containerView.addSubview(starImage)
        containerView.addConstraint(NSLayoutConstraint(item: starImage, attribute: .top, relatedBy: .equal, toItem: descriptionLabel, attribute: .bottom, multiplier: 1, constant: 22))
        containerView.addConstraint(NSLayoutConstraint(item: starImage, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 16))
        starImage.addConstraint(NSLayoutConstraint(item: starImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 12))
        starImage.addConstraint(NSLayoutConstraint(item: starImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 12))
        
        containerView.addSubview(starCountLabel)
        starCountLabel.addConstraint(NSLayoutConstraint(item: starCountLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 24))
        starCountLabel.addConstraint(NSLayoutConstraint(item: starCountLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 44))
        containerView.addConstraint(NSLayoutConstraint(item: starCountLabel, attribute: .top, relatedBy: .equal, toItem: descriptionLabel, attribute: .bottom, multiplier: 1, constant: 16))
        containerView.addConstraint(NSLayoutConstraint(item: starCountLabel, attribute: .leading, relatedBy: .equal, toItem: starImage, attribute: .leading, multiplier: 1, constant: 16))
        
        containerView.addSubview(ovalImage)
        containerView.addConstraint(NSLayoutConstraint(item: ovalImage, attribute: .top, relatedBy: .equal, toItem: descriptionLabel, attribute: .bottom, multiplier: 1, constant: 22))
        containerView.addConstraint(NSLayoutConstraint(item: ovalImage, attribute: .leading, relatedBy: .equal, toItem: starCountLabel, attribute: .trailing, multiplier: 1, constant: 4))
        ovalImage.addConstraint(NSLayoutConstraint(item: ovalImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 12))
        ovalImage.addConstraint(NSLayoutConstraint(item: ovalImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 12))
        
        containerView.addSubview(languageLabel)

        containerView.addConstraint(NSLayoutConstraint(item: languageLabel, attribute: .top, relatedBy: .equal, toItem: descriptionLabel, attribute: .bottom, multiplier: 1, constant: 16))
        containerView.addConstraint(NSLayoutConstraint(item: languageLabel, attribute: .leading, relatedBy: .equal, toItem: ovalImage, attribute: .trailing, multiplier: 1, constant: 4))
        languageLabel.addConstraint(NSLayoutConstraint(item: languageLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 24))
        containerView.addConstraint(NSLayoutConstraint(item: languageLabel, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: -5))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

