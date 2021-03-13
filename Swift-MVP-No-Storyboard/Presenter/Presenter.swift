//
//  Presenter.swift
//  Swift-MVP-No-Storyboard
//
//  Created by Chamath Jeevan on 2021-03-09.
//

import Foundation
protocol PresenterProtocol: AnyObject {
    
    func fetchProfile()
    func viewAllPinnedRepors() -> [RepositoryViewModel]
    func viewAllTopRepors() -> [RepositoryViewModel]
    func viewAllStartedRepors() -> [RepositoryViewModel]
    func loadMorePinnedRepors() -> [RepositoryViewModel]
    func loadMoreTopRepors() -> [RepositoryViewModel]
    func loadMoreStartedRepors() -> [RepositoryViewModel]
}

protocol PresenterDelegate: AnyObject {
    func render(errorMessage: String)
    func renderLoading()
    func renderProfile(profile: ProfileViewModel)
}

class Presenter : PresenterProtocol {
    
    private var service: ProfileServicesProtocol
    var delegate: PresenterDelegate?
    private var profile:Profile!
    var profileView:ProfileViewModel!
    private var pinLimit:Int = 2
    private var pinTop:Int = 2
    private var pinSart:Int = 2
    
    init(service: ProfileServicesProtocol, delegate: PresenterDelegate?) {
        self.service = service
        
        self.delegate = delegate
    }
    
    
    func fetchProfile() {
        service.fetchProfile { result in
            switch result {
            case .failure(let error):
                
                self.delegate?.render(errorMessage: "\(error)")
            case .success(let profile):
                self.profile = profile
                self.profileView = self.mapProfileViewModel(profile)
                self.delegate?.renderProfile(profile: self.profileView)
            }
        }
    }
    
    private func mapProfileViewModel(_ profile: Profile) -> ProfileViewModel {
        
        var pinnedRepoViewModels = [RepositoryViewModel]()
        
        for i in 0 ..< profile.pinnedRepositories.count {
            
            if  i > pinLimit {
                break
            }
            pinnedRepoViewModels.append(RepositoryViewModel(imageUrl: "", name: profile.pinnedRepositories[i].name, title: profile.pinnedRepositories[i].title, description: profile.pinnedRepositories[i].description, stargazer: profile.pinnedRepositories[i].stargazerCount, language: profile.pinnedRepositories[i].primaryLanguage))
        }
        
        var topRepoViewModels = [RepositoryViewModel]()
        for i in 0 ..< profile.topRepositories.count {
            if i > pinTop {
                break
            }
            topRepoViewModels.append(RepositoryViewModel(imageUrl: "", name: profile.topRepositories[i].name, title: profile.topRepositories[i].title, description: profile.topRepositories[i].description, stargazer: profile.topRepositories[i].stargazerCount, language: profile.topRepositories[i].primaryLanguage))
        }
        
        var starredRepoViewModels = [RepositoryViewModel]()
        for i in 0 ..< profile.startedRepositories.count {
            if i > pinSart {
                break
            }
            starredRepoViewModels.append(RepositoryViewModel(imageUrl: "", name: profile.startedRepositories[i].name, title: profile.startedRepositories[i].title, description: profile.startedRepositories[i].description, stargazer: profile.startedRepositories[i].stargazerCount, language: profile.startedRepositories[i].primaryLanguage))
        }
        
        var profileViewModel = ProfileViewModel(imageUrl: profile.imageUrl, name: profile.name, login: profile.login, email: profile.email, followers: profile.followers, following: profile.following)
        profileViewModel.pinnedRepositories = pinnedRepoViewModels;
        profileViewModel.topRepositories = topRepoViewModels
        profileViewModel.startedRepositories = starredRepoViewModels
        return profileViewModel
    }
    
    func viewAllPinnedRepors()  -> [RepositoryViewModel]{
        var pinnedRepoViewModels = [RepositoryViewModel]()
        
        guard let topRepos =  profile.pinnedRepositories else {
            return [RepositoryViewModel]()
        }
        for i in 0 ..< topRepos.count {
            
            pinnedRepoViewModels.append(RepositoryViewModel(imageUrl: "", name: topRepos[i].name, title: topRepos[i].title, description: topRepos[i].description, stargazer: topRepos[i].stargazerCount, language: topRepos[i].primaryLanguage))
        }
        return pinnedRepoViewModels
    }
    
    func viewAllTopRepors()  -> [RepositoryViewModel] {
        var topRepoViewModels = [RepositoryViewModel]()
        
        guard let topRepos =  profile.topRepositories else {
            return [RepositoryViewModel]()
        }
        for i in 0 ..< topRepos.count {
            
            topRepoViewModels.append(RepositoryViewModel(imageUrl: "", name: topRepos[i].name, title: topRepos[i].title, description: topRepos[i].description, stargazer: topRepos[i].stargazerCount, language: topRepos[i].primaryLanguage))
        }
        return topRepoViewModels
    }
    func viewAllStartedRepors()  -> [RepositoryViewModel] {
        var starredRepoViewModels = [RepositoryViewModel]()
        
        guard let startedRepos =  profile.startedRepositories else {
            return [RepositoryViewModel]()
        }
        for i in 0 ..< startedRepos.count {
            
            starredRepoViewModels.append(RepositoryViewModel(imageUrl: "", name: startedRepos[i].name, title: startedRepos[i].title, description: startedRepos[i].description, stargazer: startedRepos[i].stargazerCount, language: startedRepos[i].primaryLanguage))
        }
        return starredRepoViewModels
    }
    
    func loadMorePinnedRepors() -> [RepositoryViewModel] {
        var pinnedRepoViewModels = [RepositoryViewModel]()
        
        guard let topRepos =  profile.pinnedRepositories else {
            return [RepositoryViewModel]()
        }
        for i in 0 ..< topRepos.count {
            if i >  profileView.pinnedRepositories.count + 2  {  // Load two more items
                break
            }
            pinnedRepoViewModels.append(RepositoryViewModel(imageUrl: "", name: topRepos[i].name, title: topRepos[i].title, description: topRepos[i].description, stargazer: topRepos[i].stargazerCount, language: topRepos[i].primaryLanguage))
        }
        return pinnedRepoViewModels
    }
    
    func loadMoreTopRepors() -> [RepositoryViewModel] {
        var topRepoViewModels = [RepositoryViewModel]()
        
        guard let topRepos =  profile.topRepositories else {
            return [RepositoryViewModel]()
        }
        for i in 0 ..< topRepos.count {
            if i >  profileView.topRepositories.count + 2 {
                break
            }
            topRepoViewModels.append(RepositoryViewModel(imageUrl: "", name: topRepos[i].name, title: topRepos[i].title, description: topRepos[i].description, stargazer: topRepos[i].stargazerCount, language: topRepos[i].primaryLanguage))
        }
        return topRepoViewModels
    }
    func loadMoreStartedRepors() -> [RepositoryViewModel] {
        var starredRepoViewModels = [RepositoryViewModel]()
        
        guard let startedRepos =  profile.startedRepositories else {
            return [RepositoryViewModel]()
        }
        for i in 0 ..< startedRepos.count {
            if i >  profileView.startedRepositories.count + 2 {
                break
            }
            starredRepoViewModels.append(RepositoryViewModel(imageUrl: "", name: startedRepos[i].name, title: startedRepos[i].title, description: startedRepos[i].description, stargazer: startedRepos[i].stargazerCount, language: startedRepos[i].primaryLanguage))
        }
        return starredRepoViewModels
    }
    
}
