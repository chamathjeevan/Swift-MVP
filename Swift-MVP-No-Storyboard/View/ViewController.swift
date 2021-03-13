//
//  ViewController.swift
//  Swift-MVP-No-Storyboard
//
//  Created by Chamath Jeevan on 2021-03-09.
//

import UIKit

class ViewController: UIViewController,PresenterDelegate {
    
    var presenter: PresenterProtocol?
    var pinnedRepos = [RepositoryViewModel]()
    var topRepos = [RepositoryViewModel]()
    var startRepos = [RepositoryViewModel]()
    var profile:ProfileViewModel!
    
    var pinCollectionview: UICollectionView!
    var topCollectionview: UICollectionView!
    var startCollectionview: UICollectionView!
    
    var cellIdPinned = "pinnedCell"
    var cellIdTop = "topCell"
    var cellIdStart = "startCell"
    
    var pinnedRefresher = UIRefreshControl()
    let topActivityView = UIActivityIndicatorView()
    let startedActivityView = UIActivityIndicatorView()
    var isPinnedLoading = false
    var isStartedLoading = false
    var isTopLoading = false
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
        label.font = UIFont(name:"SourceSansPro-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let  messageLabel: UILabel = {
        let label =   UILabel()
        label.text = "Fecthing github profile data. Please wait ..."
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = UIColor.gray
        label.font = UIFont(name:"SourceSansPro-regular", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let profileServices = ProfileServices();
        
        presenter = Presenter(service: profileServices, delegate: self)
        
        self.view.addSubview(headerLabel)
        let guide = self.view.safeAreaLayoutGuide
        
        self.view.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        headerLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 16).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        self.view.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16).isActive = true
        messageLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16).isActive = true
        messageLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.presenter?.fetchProfile()
        
    }
    func mainRendering() -> Void {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: 1360)
        
        
        var bioView = UIView()
        
        if let pro = profile {
            bioView = addProfileBioView(profileName: pro.name,imageUrl: pro.imageUrl,loggin: pro.login, email: pro.email, follower: pro.followers, following: pro.following)
        }
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
        viewAllPinnButton.addTarget(self, action: #selector(self.loadAllPinnedRepos), for: .touchUpInside)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width-32, height: 164)
        layout.minimumLineSpacing = 15
        layout.scrollDirection = .vertical
        let pinnedFrame =  CGRect(x: 16, y: 248, width: self.view.frame.width - 32, height: 525)
        
        pinCollectionview = UICollectionView(frame: pinnedFrame, collectionViewLayout: layout)
        pinCollectionview?.register(RepositoryCell.self, forCellWithReuseIdentifier: cellIdPinned)
        pinCollectionview?.backgroundColor = UIColor.white
        pinCollectionview.tag = 777
        pinCollectionview.dataSource = self
        pinCollectionview.delegate = self
        pinCollectionview.bounces = true
        pinCollectionview.showsVerticalScrollIndicator = true
        pinCollectionview.alwaysBounceVertical = true
        pinCollectionview.contentInset.bottom = 70
        
        pinnedRefresher.tintColor = UIColor.black
        pinnedRefresher.addTarget(self, action: #selector(loadMorePinnedRepos), for: .valueChanged)
        pinCollectionview.addSubview(pinnedRefresher)
        scrollView.addSubview(pinCollectionview)
        
        
        let  topRepoLabel = getListTitleLebal(labelText: "Top repositories")
        
        scrollView.addSubview(topRepoLabel)
        topRepoLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        topRepoLabel.topAnchor.constraint(equalTo: pinCollectionview.bottomAnchor, constant: 24).isActive = true
        
        let  viewAllTopButton = getUnderlineButton(buttonText: caption)
        
        scrollView.addSubview(viewAllTopButton)
        viewAllTopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        viewAllTopButton.topAnchor.constraint(equalTo: pinCollectionview.bottomAnchor, constant: 24).isActive = true
        viewAllTopButton.addTarget(self, action: #selector(self.loadAllTopRepos), for: .touchUpInside)
        
        
        let horizontalLayout = UICollectionViewFlowLayout()
        horizontalLayout.itemSize = CGSize(width: 200, height: 164)
        horizontalLayout.minimumLineSpacing = 15
        horizontalLayout.scrollDirection = .horizontal
        let topFrame =  CGRect(x: 16, y: 845, width: self.view.frame.width - 32, height: 164)
        topCollectionview = UICollectionView(frame: topFrame, collectionViewLayout: horizontalLayout)
        topCollectionview?.register(RepositoryCell.self, forCellWithReuseIdentifier: cellIdTop)
        topCollectionview?.backgroundColor = UIColor.white
        topCollectionview.tag = 787
        topCollectionview.dataSource = self
        topCollectionview.delegate = self
        topCollectionview.addSubview(topActivityView)
        scrollView.addSubview(topCollectionview)
        
        
        let  starredRepoLabel = getListTitleLebal(labelText: "Starred repositories")
        
        scrollView.addSubview(starredRepoLabel)
        starredRepoLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        starredRepoLabel.topAnchor.constraint(equalTo: topCollectionview.bottomAnchor, constant: 24).isActive = true
        
        let  viewAllStarredButton = getUnderlineButton(buttonText: caption)
        
        scrollView.addSubview(viewAllStarredButton)
        viewAllStarredButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        viewAllStarredButton.topAnchor.constraint(equalTo: topCollectionview.bottomAnchor, constant: 24).isActive = true
        viewAllStarredButton.addTarget(self, action: #selector(self.loadAllStartRepos), for: .touchUpInside)
        let horizontalStartLayout = UICollectionViewFlowLayout()
        horizontalStartLayout.itemSize = CGSize(width: 200, height: 164)
        horizontalStartLayout.minimumLineSpacing = 15
        horizontalStartLayout.scrollDirection = .horizontal
        let startFrame =  CGRect(x: 16, y: 1081, width: self.view.frame.width - 32, height: 164)
        startCollectionview = UICollectionView(frame: startFrame, collectionViewLayout: horizontalStartLayout)
        startCollectionview?.register(RepositoryCell.self, forCellWithReuseIdentifier: cellIdStart)
        startCollectionview?.backgroundColor = UIColor.white
        startCollectionview.tag = 747
        startCollectionview.dataSource = self
        startCollectionview.delegate = self
        startCollectionview!.alwaysBounceVertical = false
        startCollectionview!.alwaysBounceHorizontal = true
        startedActivityView.isHidden = false
        startCollectionview.addSubview(startedActivityView)
        
        scrollView.addSubview(startCollectionview)
    }
    func addProfileBioView(profileName:String,imageUrl:String,loggin:String,email:String,follower:String,following:String)-> UIView{
        
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
        profileImage.loadImageUsingCache(withUrl: imageUrl)
        let nameLabel =   UILabel()
        
        nameLabel.text = profileName
        
        nameLabel.font = UIFont(name:"SourceSansPro-Bold", size: 32.0)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        bioView.addSubview(nameLabel)
        nameLabel.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 40))
        bioView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: bioView, attribute: .top, multiplier: 1, constant: 12))
        bioView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: profileImage, attribute: .trailing, multiplier: 1, constant: 8))
        
        bioView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: bioView, attribute: .trailing, multiplier: 1, constant: -5))
        
        let loginLabel = getHeaderLebal(labelText: loggin,boldLength: 0)
        
        bioView.addSubview(loginLabel)
        
        
        bioView.addConstraint(NSLayoutConstraint(item: loginLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1, constant: 0))
        bioView.addConstraint(NSLayoutConstraint(item: loginLabel, attribute: .leading, relatedBy: .equal, toItem: profileImage, attribute: .trailing, multiplier: 1, constant: 8))
        
        bioView.addConstraint(NSLayoutConstraint(item: loginLabel, attribute: .trailing, relatedBy: .equal, toItem: bioView, attribute: .trailing, multiplier: 1, constant: -5))
        
        
        let emailLabel =    getHeaderLebal(labelText: email,boldLength: email.count)
        
        bioView.addSubview(emailLabel)
        
        
        
        bioView.addConstraint(NSLayoutConstraint(item: emailLabel, attribute: .top, relatedBy: .equal, toItem: loginLabel, attribute: .bottom, multiplier: 1, constant: 36))
        bioView.addConstraint(NSLayoutConstraint(item: emailLabel, attribute: .leading, relatedBy: .equal, toItem: bioView, attribute: .leading, multiplier: 1, constant: 16))
        
        bioView.addConstraint(NSLayoutConstraint(item: emailLabel, attribute: .trailing, relatedBy: .equal, toItem: bioView, attribute: .trailing, multiplier: 1, constant: -5))
        
        
        let followersLabel =  getHeaderLebal(labelText: "\(follower) followers",boldLength: follower.count)
        
        bioView.addSubview(followersLabel)
        
        followersLabel.addConstraint(NSLayoutConstraint(item: followersLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 106))
        
        bioView.addConstraint(NSLayoutConstraint(item: followersLabel, attribute: .top, relatedBy: .equal, toItem: emailLabel, attribute: .bottom, multiplier: 1, constant: 16))
        bioView.addConstraint(NSLayoutConstraint(item: followersLabel, attribute: .leading, relatedBy: .equal, toItem: bioView, attribute: .leading, multiplier: 1, constant: 16))
        
        let followingLabel =  getHeaderLebal(labelText: "\(following) following" ,boldLength: following.count)
        
        bioView.addSubview(followingLabel)
        
        followingLabel.addConstraint(NSLayoutConstraint(item: followingLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,multiplier: 1, constant: 106))
        
        bioView.addConstraint(NSLayoutConstraint(item: followingLabel, attribute: .top, relatedBy: .equal, toItem: emailLabel, attribute: .bottom, multiplier: 1, constant: 16))
        bioView.addConstraint(NSLayoutConstraint(item: followingLabel, attribute: .leading, relatedBy: .equal, toItem: followersLabel, attribute: .trailing, multiplier: 1, constant: 0))
        return bioView
    }
    
    private func getUnderlineButton(buttonText:String) -> UIButton {
        let  underLineButton: UIButton = {
            let button = UIButton()
            
            let attributedTitle = NSMutableAttributedString(string: buttonText)
            
            let font = UIFont(name:"SourceSansPro-Bold", size: 20)
            attributedTitle.addAttributes([.underlineStyle : NSUnderlineStyle.single.rawValue],range: NSRange(location: 0, length:buttonText.count))
            attributedTitle.addAttributes([.foregroundColor : UIColor.black],range: NSRange(location: 0, length: buttonText.count))
            attributedTitle.addAttributes([.font : font!],range: NSRange(location: 0, length: buttonText.count))
            
            button.setAttributedTitle(attributedTitle, for: .selected)
            button.setAttributedTitle(attributedTitle, for: .normal)
            button.titleLabel?.font = UIFont(name:"SourceSansPro-Bold", size: 16)
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
            label.font = UIFont(name:"SourceSansPro-Bold", size: 24)
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
                label.font = UIFont(name:"SourceSansPro-Regular", size: 16)
            }else{
                let attributedTitle = NSMutableAttributedString(string: labelText)
                let font = UIFont(name:"SourceSansPro-Regular", size: 16)
                let fontBold = UIFont(name:"SourceSansPro-Bold", size: 16)
                
                var largeLength = boldLength
                if(labelText.count < boldLength) {
                    largeLength = labelText.count
                }
                
                attributedTitle.addAttributes([.font : fontBold!],range: NSRange(location: 0, length: labelText.count))
                attributedTitle.addAttributes([.font : font!],range: NSRange(location: largeLength, length: labelText.count - largeLength))
                label.attributedText = attributedTitle
                
            }
            label.translatesAutoresizingMaskIntoConstraints = false
            label.heightAnchor.constraint(equalToConstant: 24).isActive = true
            
            return label
        }()
        
        return listLabel
    }
    // MARK: - Presenter delegate calles
    
    func render(errorMessage: String) {
        messageLabel.text = "ERROR: Unable to fetch github data. please verify github security token."
        messageLabel.textColor = UIColor.red
        messageLabel.isHidden = false
        print(errorMessage)
    }
    
    func renderLoading() {
    }
    
    func renderProfile(profile: ProfileViewModel) {
        
        self.profile = profile
        
        self.messageLabel.isHidden = true
        self.mainRendering()
        if let pinnRepo = profile.pinnedRepositories {
            self.pinnedRepos = pinnRepo
            DispatchQueue.main.async {
                self.pinCollectionview.reloadData()
            }
        }
        
        if let topRepo = profile.topRepositories {
            self.topRepos = topRepo
            DispatchQueue.main.async {
                self.topCollectionview.reloadData()
            }
        }
        
        if let startRepo = profile.startedRepositories {
            self.startRepos = startRepo
            DispatchQueue.main.async {
                self.startCollectionview.reloadData()
            }
        }
    }
    // MARK: - Implementation of refresh feature for vertical list
    @objc func loadMorePinnedRepos() {
        if let reFresh =  self.pinCollectionview!.refreshControl {
            reFresh.beginRefreshing()
        }
        pinnedRefresher.beginRefreshing()
        if let repos = presenter?.loadMorePinnedRepors(){
            self.pinnedRepos = repos
            DispatchQueue.main.async {
                self.pinCollectionview.reloadData()
                self.pinnedRefresher.endRefreshing()
            }
        }
    }
    // MARK: - Method implementation for view all buttons
    @objc func loadAllPinnedRepos() {
        
        if let repos = presenter?.viewAllPinnedRepors(){
            self.pinnedRepos = repos
            DispatchQueue.main.async {
                self.pinCollectionview.reloadData()
            }
        }
    }
    
    @objc func loadAllTopRepos() {
        
        if let repos = presenter?.viewAllTopRepors() {
            self.topRepos = repos
            
            DispatchQueue.main.async {
                self.topCollectionview.reloadData()
            }
        }
    }
    
    @objc func loadAllStartRepos() {
        
        if let repos = presenter?.viewAllStartedRepors(){
            self.startRepos = repos
            DispatchQueue.main.async {
                self.startCollectionview.reloadData()
            }
        }
    }
}
// MARK: - UICollectionView delegate calles

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 777 {
            return self.pinnedRepos.count
        }else if collectionView.tag == 787 {
            return self.topRepos.count
        }else{
            return self.startRepos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell:RepositoryCell
        var repo: RepositoryViewModel
        
        if collectionView.tag == 777 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdPinned, for: indexPath as IndexPath) as! RepositoryCell
            repo = pinnedRepos[indexPath.row]
        }else if collectionView.tag == 787 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdTop, for: indexPath as IndexPath) as! RepositoryCell
            repo = topRepos[indexPath.row]
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdStart, for: indexPath as IndexPath) as! RepositoryCell
            if indexPath.item == startRepos.count{
                return cell
            }
            repo = startRepos[indexPath.row]
        }
        cell.profileImage.loadImageUsingCache(withUrl: profile.imageUrl)
        cell.nameLabel.text = repo.name
        cell.titleLabel.text = repo.title
        cell.descriptionLabel.text = repo.description
        cell.starCountLabel.text = repo.stargazer
        cell.languageLabel.text = repo.language
        return cell
    }
    
    // MARK: - Implementaion of pull to refresh functionaly for UICollectionView views
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.tag == 787) {
            
            let content = ((scrollView.contentSize.width - scrollView.bounds.width) + 30)
            if (content < scrollView.contentOffset.x){
                topActivityView.isHidden = false
                topActivityView.frame = CGRect(x: (scrollView.contentSize.width + 15), y: 0, width: 60, height: 164)
                topActivityView.startAnimating()
                if ((content + 50) < scrollView.contentOffset.x){
                    if !isTopLoading{
                        isTopLoading = true
                        if let repos = presenter?.loadMoreTopRepors() {
                            self.topRepos = repos
                            DispatchQueue.main.async {
                                self.topActivityView.isHidden = true
                                self.topCollectionview.reloadData()
                                self.isStartedLoading = false
                            }
                        }
                    }
                }
            }
        }
        else if(scrollView.tag == 747) {
            
            let content = ((scrollView.contentSize.width - scrollView.bounds.width) + 30)
            if (content < scrollView.contentOffset.x){
                startedActivityView.isHidden = false
                startedActivityView.frame = CGRect(x: (scrollView.contentSize.width + 15), y: 0, width: 60, height: 164)
                startedActivityView.startAnimating()
                if ((content + 50) < scrollView.contentOffset.x){
                    if !isStartedLoading{
                        isStartedLoading = true
                        if let repos = presenter?.loadMoreStartedRepors() {
                            self.startRepos = repos
                            DispatchQueue.main.async {
                                self.startedActivityView.isHidden = true
                                self.startCollectionview.reloadData()
                                self.isStartedLoading = false
                            }
                        }
                    }
                }
            }
        }
    }
}

