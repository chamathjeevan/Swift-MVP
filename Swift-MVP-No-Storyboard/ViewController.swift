//
//  ViewController.swift
//  Swift-MVP-No-Storyboard
//
//  Created by Chamath Jeevan on 2021-03-09.
//

import UIKit

class ViewController: UIViewController {
    var presenter: PresenterProtocol?
    var pinnedRepos = [RepositoryViewModel]()
    var topRepos = [RepositoryViewModel]()
    var startRepos = [RepositoryViewModel]()
    
    var pinCollectionview: UICollectionView!
    var topCollectionview: UICollectionView!
    var startCollectionview: UICollectionView!
    
    var cellId = "repoCell"
    let caption = "View All"
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let  headerLabel: UILabel = {
        let label =   UILabel()
        label.text = "Profile"
        label.textAlignment = .center
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(with presenter: PresenterProtocol){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        pinnedRepos.append(RepositoryViewModel(imageUrl: "setaylor", name: "telegraph-android", title: "Telegraph X is Android client", description: "Kotlin", stargazer: "74", language: "Ruby"))
        pinnedRepos.append(RepositoryViewModel(imageUrl: "setaylor", name: "telegraph-android", title: "Telegraph X is Android client", description: "Kotlin", stargazer: "74", language: "Ruby"))
        pinnedRepos.append(RepositoryViewModel(imageUrl: "setaylor", name: "telegraph-android", title: "Telegraph X is Android client", description: "Kotlin", stargazer: "74", language: "Ruby"))
        
        topRepos.append(RepositoryViewModel(imageUrl: "top setaylor", name: "telegraph-android", title: "Telegraph X is Android client", description: "Ruby", stargazer: "74", language: "Ruby"))
        topRepos.append(RepositoryViewModel(imageUrl: "top setaylor", name: "telegraph-android", title: "Telegraph X is Android client", description: "Ruby", stargazer: "74", language: "Ruby"))
        topRepos.append(RepositoryViewModel(imageUrl: "top setaylor", name: "telegraph-android", title: "Telegraph X is Android client", description: "Ruby", stargazer: "74", language: "Ruby"))
        startRepos.append(RepositoryViewModel(imageUrl: "Start setaylor", name: "telegraph-android", title: "Telegraph X is Android client", description: "C#", stargazer: "74", language: "C#"))
        startRepos.append(RepositoryViewModel(imageUrl: "Start setaylor", name: "telegraph-android", title: "Telegraph X is Android client", description: "C#", stargazer: "74", language: "C#"))
        startRepos.append(RepositoryViewModel(imageUrl: "Start setaylor", name: "telegraph-android", title: "Telegraph X is Android client", description: "C#", stargazer: "74", language: "C#"))
        self.view.addSubview(headerLabel)
        
        let guide = self.view.safeAreaLayoutGuide
        
        
        self.view.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1360)
        
        let bioView = addProfileBioView()
        
        scrollView.addSubview(bioView)
        bioView.translatesAutoresizingMaskIntoConstraints = false
        bioView.backgroundColor = UIColor.white
        
        bioView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        bioView.topAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        bioView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        bioView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let  pinnedLabel = getListTitleLebal(labelText: "Pinned")
        
        scrollView.addSubview(pinnedLabel)
        pinnedLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        pinnedLabel.topAnchor.constraint(equalTo: bioView.bottomAnchor).isActive = true
        
        let  viewAllPinnButton = getUnderlineButton(buttonText: caption)
        scrollView.addSubview(viewAllPinnButton)
        viewAllPinnButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        viewAllPinnButton.topAnchor.constraint(equalTo: bioView.bottomAnchor).isActive = true
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width-32, height: 164)
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .vertical
        let pinnedFrame =  CGRect(x: 16, y: 248, width: self.view.frame.width - 32, height: 525)
        
        
        pinCollectionview = UICollectionView(frame: pinnedFrame, collectionViewLayout: layout)
        pinCollectionview?.register(RepositoryCell.self, forCellWithReuseIdentifier: cellId)
        pinCollectionview?.backgroundColor = UIColor.white
        pinCollectionview.tag = 777
        pinCollectionview.dataSource = self
        pinCollectionview.delegate = self
        let pinnedRefresher = UIRefreshControl()
        
        pinnedRefresher.attributedTitle = NSAttributedString(string: "Load more pinned repos")
        pinnedRefresher.addTarget(self, action: #selector(loadMoreStartRepos), for: .valueChanged)
        pinCollectionview.addSubview(pinnedRefresher)
        pinCollectionview.refreshControl = pinnedRefresher
        scrollView.addSubview(pinCollectionview)
        
        
        let  topRepoLabel = getListTitleLebal(labelText: "Top repositories")
        
        scrollView.addSubview(topRepoLabel)
        topRepoLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        topRepoLabel.topAnchor.constraint(equalTo: pinCollectionview.bottomAnchor, constant: 24).isActive = true
        
        let  viewAllTopButton = getUnderlineButton(buttonText: caption)
        
        scrollView.addSubview(viewAllTopButton)
        viewAllTopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        viewAllTopButton.topAnchor.constraint(equalTo: pinCollectionview.bottomAnchor, constant: 24).isActive = true
        
        
        
        let horizontalLayout = UICollectionViewFlowLayout()
        horizontalLayout.itemSize = CGSize(width: 200, height: 164)
        horizontalLayout.minimumLineSpacing = 15
        horizontalLayout.scrollDirection = .horizontal
        let topFrame =  CGRect(x: 16, y: 845, width: self.view.frame.width - 32, height: 164)
        topCollectionview = UICollectionView(frame: topFrame, collectionViewLayout: horizontalLayout)
        topCollectionview?.register(RepositoryCell.self, forCellWithReuseIdentifier: cellId)
        topCollectionview?.backgroundColor = UIColor.white
        topCollectionview.tag = 787
        topCollectionview.dataSource = self
        topCollectionview.delegate = self
        let topRefresher = UIRefreshControl()
        
        topRefresher.attributedTitle = NSAttributedString(string: "Load more top repos")
        topRefresher.addTarget(self, action: #selector(loadMoreStartRepos), for: .valueChanged)
        topCollectionview.addSubview(topRefresher)
        topCollectionview.refreshControl = topRefresher
        
        scrollView.addSubview(topCollectionview)
        
        
        let  starredRepoLabel = getListTitleLebal(labelText: "Starred repositories")
        
        scrollView.addSubview(starredRepoLabel)
        starredRepoLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        starredRepoLabel.topAnchor.constraint(equalTo: topCollectionview.bottomAnchor, constant: 24).isActive = true
        
        let  viewAllStarredButton = getUnderlineButton(buttonText: caption)
        
        scrollView.addSubview(viewAllStarredButton)
        viewAllStarredButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        viewAllStarredButton.topAnchor.constraint(equalTo: topCollectionview.bottomAnchor, constant: 24).isActive = true
        
        let horizontalStartLayout = UICollectionViewFlowLayout()
        horizontalStartLayout.itemSize = CGSize(width: 200, height: 164)
        horizontalStartLayout.minimumLineSpacing = 15
        horizontalStartLayout.scrollDirection = .horizontal
        let startFrame =  CGRect(x: 16, y: 1081, width: self.view.frame.width - 32, height: 164)
        startCollectionview = UICollectionView(frame: startFrame, collectionViewLayout: horizontalStartLayout)
        startCollectionview?.register(RepositoryCell.self, forCellWithReuseIdentifier: cellId)
        startCollectionview?.backgroundColor = UIColor.white
        startCollectionview.tag = 747
        startCollectionview.dataSource = self
        startCollectionview.delegate = self
        startCollectionview!.alwaysBounceVertical = false
        startCollectionview!.alwaysBounceHorizontal = true
        
        let startRefresher = UIRefreshControl()
        
        startRefresher.attributedTitle = NSAttributedString(string: "Load more started repos")
        startRefresher.addTarget(self, action: #selector(loadMoreStartRepos), for: .valueChanged)
        startCollectionview.addSubview(startRefresher)
        startCollectionview.refreshControl = startRefresher
        
        scrollView.addSubview(startCollectionview)
        
    }
    
    func addProfileBioView()-> UIView{
        
        let bioView = UIView()
        
        let profileImage =   UIImageView()
        profileImage.image = UIImage(named: "Avatar")
        profileImage.layer.cornerRadius = 44
        profileImage.clipsToBounds = true
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        bioView.addSubview(profileImage)
        bioView.addConstraint(NSLayoutConstraint(item: profileImage, attribute: .top, relatedBy: .equal, toItem: bioView, attribute: .top, multiplier: 1, constant: 0))
        bioView.addConstraint(NSLayoutConstraint(item: profileImage, attribute: .leading, relatedBy: .equal, toItem: bioView, attribute: .leading, multiplier: 1, constant: 16))
        profileImage.addConstraint(NSLayoutConstraint(item: profileImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 88))
        profileImage.addConstraint(NSLayoutConstraint(item: profileImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 88))
        
        let nameLabel =   UILabel()
        nameLabel.text = "Chamath Jeevan"
        nameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 32.0)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        bioView.addSubview(nameLabel)
        nameLabel.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 40))
        bioView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: bioView, attribute: .top, multiplier: 1, constant: 12))
        bioView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: profileImage, attribute: .trailing, multiplier: 1, constant: 8))
        
        bioView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: bioView, attribute: .trailing, multiplier: 1, constant: -5))
        
        let loginLabel = getHeaderLebal(labelText: "setaylor",boldLength: 0)
        
        bioView.addSubview(loginLabel)
        
        
        bioView.addConstraint(NSLayoutConstraint(item: loginLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 0))
        bioView.addConstraint(NSLayoutConstraint(item: loginLabel, attribute: .leading, relatedBy: .equal, toItem: profileImage, attribute: .trailing, multiplier: 1, constant: 8))
        
        bioView.addConstraint(NSLayoutConstraint(item: loginLabel, attribute: .trailing, relatedBy: .equal, toItem: bioView, attribute: .trailing, multiplier: 1, constant: -5))
        
        
        let emailLabel =    getHeaderLebal(labelText: "s.e.taylor@gmail.com",boldLength: "s.e.taylor@gmail.com".count)
        
        bioView.addSubview(emailLabel)
        
        
        
        bioView.addConstraint(NSLayoutConstraint(item: emailLabel, attribute: .top, relatedBy: .equal, toItem: loginLabel, attribute: .bottom, multiplier: 1, constant: 36))
        bioView.addConstraint(NSLayoutConstraint(item: emailLabel, attribute: .leading, relatedBy: .equal, toItem: bioView, attribute: .leading, multiplier: 1, constant: 16))
        
        bioView.addConstraint(NSLayoutConstraint(item: emailLabel, attribute: .trailing, relatedBy: .equal, toItem: bioView, attribute: .trailing, multiplier: 1, constant: -5))
        
        
        let followersLabel =  getHeaderLebal(labelText: "48 followers",boldLength: 2)
        
        bioView.addSubview(followersLabel)
        
        followersLabel.addConstraint(NSLayoutConstraint(item: followersLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 106))
        
        bioView.addConstraint(NSLayoutConstraint(item: followersLabel, attribute: .top, relatedBy: .equal, toItem: emailLabel, attribute: .bottom, multiplier: 1, constant: 16))
        bioView.addConstraint(NSLayoutConstraint(item: followersLabel, attribute: .leading, relatedBy: .equal, toItem: bioView, attribute: .leading, multiplier: 1, constant: 16))
        
        let followingLabel =  getHeaderLebal(labelText: "72 following",boldLength: 2)
        
        bioView.addSubview(followingLabel)
        
        followingLabel.addConstraint(NSLayoutConstraint(item: followingLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 106))
        
        bioView.addConstraint(NSLayoutConstraint(item: followingLabel, attribute: .top, relatedBy: .equal, toItem: emailLabel, attribute: .bottom, multiplier: 1, constant: 16))
        bioView.addConstraint(NSLayoutConstraint(item: followingLabel, attribute: .leading, relatedBy: .equal, toItem: followersLabel, attribute: .trailing, multiplier: 1, constant: 0))
        return bioView
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @objc func loadMorePinnedRepos(refreshControl: UIRefreshControl) {
        print("TODO : loadMorePinnedRepos")
        
        // somewhere in your code you might need to call:
        refreshControl.endRefreshing()     //At some point you could end refreshing.
    }
    
    @objc func loadMoreTopRepos(refreshControl: UIRefreshControl) {
        print("TODO : loadMoreTopRepos")
        
        // somewhere in your code you might need to call:
        refreshControl.endRefreshing()     //At some point you could end refreshing.
    }
    
    @objc func loadMoreStartRepos(refreshControl: UIRefreshControl) {
        print("TODO : loadMoreStartRepos")
        
        // somewhere in your code you might need to call:
        refreshControl.endRefreshing()     //At some point you could end refreshing.
    }
    
    
    private func getUnderlineButton(buttonText:String) -> UIButton {
        let  underLineButton: UIButton = {
            let button = UIButton()
            
            let attributedTitle = NSMutableAttributedString(string: buttonText)
            
            let font = UIFont(name:"HelveticaNeue-Bold", size: 20)
            attributedTitle.addAttributes([.underlineStyle : NSUnderlineStyle.single.rawValue],range: NSRange(location: 0, length:buttonText.count))
            attributedTitle.addAttributes([.foregroundColor : UIColor.black],range: NSRange(location: 0, length: buttonText.count))
            attributedTitle.addAttributes([.font : font!],range: NSRange(location: 0, length: buttonText.count))
            
            button.setAttributedTitle(attributedTitle, for: .selected)
            button.setAttributedTitle(attributedTitle, for: .normal)
            button.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 32).isActive = true
            button.widthAnchor.constraint(equalToConstant: 90).isActive = true
            return button
        }()
        return underLineButton
    }
    
    private  func getListTitleLebal(labelText:String) -> UILabel {
        let  listLabel: UILabel = {
            let label =   UILabel()
            label.text = labelText
            label.textAlignment = .left
            label.font = UIFont(name:"HelveticaNeue-Bold", size: 24)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.heightAnchor.constraint(equalToConstant: 32).isActive = true
            label.widthAnchor.constraint(equalToConstant: 250).isActive = true
            return label
        }()
        
        return listLabel
    }
    
    private func getHeaderLebal(labelText:String,boldLength:Int) -> UILabel {
        let  listLabel: UILabel = {
            let label =   UILabel()
            if boldLength == 0 {
                label.text = labelText
                label.textAlignment = .left
                label.font = UIFont(name:"HelveticaNeue", size: 16)
            }else{
                let attributedTitle = NSMutableAttributedString(string: labelText)
                let font = UIFont(name:"HelveticaNeue", size: 16)
                let fontBold = UIFont(name:"HelveticaNeue-Bold", size: 16)
                attributedTitle.addAttributes([.font : fontBold!],range: NSRange(location: 0, length: labelText.count))
                attributedTitle.addAttributes([.font : font!],range: NSRange(location: boldLength, length: labelText.count - boldLength))
                label.attributedText = attributedTitle
                
            }
            label.translatesAutoresizingMaskIntoConstraints = false
            label.heightAnchor.constraint(equalToConstant: 24).isActive = true
            
            return label
        }()
        
        return listLabel
    }
}

extension ViewController: PresenterDelegate {
    func renderProfile(profile: ProfileViewModel) {
        
    }
    
    func render(errorMessage: String) {
        
    }
    func renderLoading() {
        
    }
    func render(profile:ProfileViewModel) {
        
    }
}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 777 {
            return startRepos.count
        }
        if collectionView.tag == 787 {
            return topRepos.count
        }else{
            return startRepos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! RepositoryCell
        
        var repo: RepositoryViewModel
        
        if collectionView.tag == 777 {
            repo = startRepos[indexPath.row]
        }
        if collectionView.tag == 787 {
            repo = topRepos[indexPath.row]
        }else{
            repo = startRepos[indexPath.row]
        }
        cell.nameLabel.text = repo.name
        cell.titleLabel.text = repo.title
        cell.descriptionLabel.text = repo.description
        cell.starCountLabel.text = repo.stargazer
        cell.languageLabel.text = repo.language
        return cell
    }
}
