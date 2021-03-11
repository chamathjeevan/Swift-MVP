//
//  Presenter.swift
//  Swift-MVP-No-Storyboard
//
//  Created by Chamath Jeevan on 2021-03-09.
//

import Foundation
protocol PresenterProtocol: AnyObject {
    func fetchProfile()
    func viewAllPinnedRepors()
    func viewAllTopRepors()
    func viewAllStartedRepors()
}

protocol PresenterDelegate: AnyObject {
    func render(errorMessage: String)
    func renderLoading()
    func renderProfile(profile: ProfileViewModel)
}

class Presenter : PresenterProtocol {
    func fetchProfile() {
    }
    
    func viewAllPinnedRepors() {
    }
    
    func viewAllTopRepors() {
    }
    func viewAllStartedRepors() {
    }
}
