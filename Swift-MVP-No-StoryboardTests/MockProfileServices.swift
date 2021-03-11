//
//  MockProfileServices.swift
//  Swift-MVP-No-StoryboardTests
//
//  Created by Chamath Jeevan on 2021-03-11.
//

import Foundation
@testable import Swift_MVP_No_Storyboard
final class MockProfileServices: ProfileServicesProtocol {
    func fetchProfile(completion: @escaping (Result<Profile, Error>) -> Void) {
        let url = " phrile.jpg"
        
        var pinnedRepos = [Repository]()
        var topRepos = [Repository]()
        var startRepos = [Repository]()
        
        pinnedRepos.append(Repository(id: UUID(), name: "Pinned-1", title: "Pinned-title-1", description: "PDes-1", stargazerCount: "10", primaryLanguage: "Ruby -1"))
        pinnedRepos.append(Repository(id: UUID(), name: "Pinned-2", title: "Pinned-title-2", description: "PDes-2", stargazerCount: "11", primaryLanguage: "Ruby -2"))
        pinnedRepos.append(Repository(id: UUID(), name: "Pinned-3", title: "Pinned-title-3", description: "PDes-3", stargazerCount: "12", primaryLanguage: "Ruby -3"))
        pinnedRepos.append(Repository(id: UUID(), name: "Pinned-4", title: "Pinned-title-4", description: "PDes-4", stargazerCount: "13", primaryLanguage: "Ruby -4"))
        pinnedRepos.append(Repository(id: UUID(), name: "Pinned-5", title: "Pinned-title-5", description: "PDes-5", stargazerCount: "14", primaryLanguage: "Ruby -5"))
        pinnedRepos.append(Repository(id: UUID(), name: "Pinned-6", title: "Pinned-title-5", description: "PDes-6", stargazerCount: "15", primaryLanguage: "Ruby -6"))
        pinnedRepos.append(Repository(id: UUID(), name: "Pinned-7", title: "Pinned-title-7", description: "PDes-7", stargazerCount: "16", primaryLanguage: "Ruby -7"))
        pinnedRepos.append(Repository(id: UUID(), name: "Pinned-8", title: "Pinned-title-8", description: "PDes-8", stargazerCount: "17", primaryLanguage: "Ruby -8"))
        pinnedRepos.append(Repository(id: UUID(), name: "Pinned-9", title: "Pinned-title-9", description: "PDes-9", stargazerCount: "18", primaryLanguage: "Ruby -9"))
        
        topRepos.append(Repository(id: UUID(), name: "top-1", title: "top-title-1", description: "TopDes-1", stargazerCount: "40", primaryLanguage: "Swift -1"))
        topRepos.append(Repository(id: UUID(), name: "top-2", title: "top-title-2", description: "TopDes-2", stargazerCount: "41", primaryLanguage: "Swift -2"))
        topRepos.append(Repository(id: UUID(), name: "top-3", title: "top-title-3", description: "TopDes-3", stargazerCount: "42", primaryLanguage: "Swift -3"))
        topRepos.append(Repository(id: UUID(), name: "top-4", title: "top-title-4", description: "TopDes-4", stargazerCount: "43", primaryLanguage: "Swift -4"))
        topRepos.append(Repository(id: UUID(), name: "top-5", title: "top-title-5", description: "TopDes-5", stargazerCount: "44", primaryLanguage: "Swift -5"))
        topRepos.append(Repository(id: UUID(), name: "top-6", title: "top-title-5", description: "TopDes-6", stargazerCount: "45", primaryLanguage: "Swift -6"))
        topRepos.append(Repository(id: UUID(), name: "top-7", title: "top-title-7", description: "TopDes-7", stargazerCount: "46", primaryLanguage: "Swift -7"))
        topRepos.append(Repository(id: UUID(), name: "top-8", title: "top-title-8", description: "TopDes-8", stargazerCount: "47", primaryLanguage: "Swift -8"))
        topRepos.append(Repository(id: UUID(), name: "top-9", title: "top-title-9", description: "TopDes-9", stargazerCount: "48", primaryLanguage: "Swift -9"))
        
        startRepos.append(Repository(id: UUID(), name: "start-1", title: "start-title-1", description: "Start-Des-1", stargazerCount: "30", primaryLanguage: "C# -1"))
        startRepos.append(Repository(id: UUID(), name: "start-2", title: "start-title-2", description: "Start-Des-2", stargazerCount: "31", primaryLanguage: "C# -2"))
        startRepos.append(Repository(id: UUID(), name: "start-3", title: "start-title-3", description: "Start-Des-3", stargazerCount: "32", primaryLanguage: "C# -3"))
        startRepos.append(Repository(id: UUID(), name: "start-4", title: "start-title-4", description: "Start-Des-4", stargazerCount: "33", primaryLanguage: "C# -4"))
        startRepos.append(Repository(id: UUID(), name: "start-5", title: "start-title-5", description: "Start-Des-5", stargazerCount: "34", primaryLanguage: "C# -5"))
        startRepos.append(Repository(id: UUID(), name: "start-6", title: "start-title-5", description: "Start-Des-6", stargazerCount: "35", primaryLanguage: "C# -6"))
        startRepos.append(Repository(id: UUID(), name: "start-7", title: "start-title-7", description: "Start-Des-7", stargazerCount: "36", primaryLanguage: "C# -7"))
        startRepos.append(Repository(id: UUID(), name: "start-8", title: "start-title-8", description: "Start-Des-8", stargazerCount: "37", primaryLanguage: "C# -8"))
        startRepos.append(Repository(id: UUID(), name: "start-9", title: "start-title-9", description: "Start-Des-9", stargazerCount: "38", primaryLanguage: "C# -9"))
        
        
        let profile = Profile(id: UUID(), imageUrl: url, name: "Sian Taylor", login: "setaylor", email: "s.e.taylor@gmail.com", followers: "45", following: "56", pinnedRepositories: pinnedRepos, topRepositories: topRepos, startedRepositories: startRepos)
        
        completion(.success(profile))
    }
    
    
}
