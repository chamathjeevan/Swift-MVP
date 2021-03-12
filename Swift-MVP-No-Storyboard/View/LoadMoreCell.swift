//
//  LoadMoreCell.swift
//  Swift-MVP-No-Storyboard
//
//  Created by Chamath Jeevan on 2021-03-12.
//

import Foundation
import Foundation
import UIKit

class LoadMoreCell: UICollectionViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true;
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(displayP3Red: 204/255, green: 204/255, blue: 204/255, alpha: 1).cgColor
        return view
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
        
        let refresher = UIRefreshControl()
        
        refresher.attributedTitle = NSAttributedString(string: "Load more...")
        containerView.addSubview(refresher)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

