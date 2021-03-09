//
//  Profile.swift
//  Swift-MVP-No-Storyboard
//
//  Created by Chamath Jeevan on 2021-03-09.
//

import Foundation

protocol ProfileServicesProtocol: AnyObject {
  func fetchProfile(completion: @escaping (Result<Profile, Error>) -> Void)
}

struct Profile {
    var id: UUID
    var imageUrl: String
    var name: String
    var login: String
    var email: String
    var followers: String
    var following: String
}
struct ProfileViewModel {
    var imageUrl: String
    var name: String
    var login: String
    var email: String
    var followers: String
    var following: String
}
