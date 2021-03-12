//
//  PresenterTest.swift
//  Swift-MVP-No-StoryboardTests
//
//  Created by Chamath Jeevan on 2021-03-11.
//

import XCTest
@testable import Swift_MVP_No_Storyboard
class PresenterTest: XCTestCase {
    var presenter:Presenter!
    
    override func setUp()  {
        let mockServices = MockProfileServices()
        presenter = Presenter(service: mockServices, delegate: nil)
        testViewModeFetched()
    }
    
    func testViewModeFetched() {
        presenter.fetchProfile()
        XCTAssert(presenter.profileView != nil)
    }
    func testViewAllPinnedRepos(){
        
        let repos =  presenter.viewAllTopRepors()
        
        XCTAssert(repos.count == 9)
        
    }
    
    func testViewAllTopRepos(){
        
        let repos =  presenter.viewAllTopRepors()
        
        XCTAssert(repos.count == 9)
        
    }
    
    func testViewAllStarRepos(){
        
        let repos =  presenter.viewAllStartedRepors()
        
        XCTAssert(repos.count == 9)
        
    }
}
