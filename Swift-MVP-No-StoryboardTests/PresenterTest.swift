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
    func test_A_LoadMorePinnedRepos(){
        let count = presenter.profileView.pinnedRepositories.count + 3
        let repos =  presenter.loadMorePinnedRepors()
        
        XCTAssert(repos.count == count)
        
    }
    func test_B_LoadMoreTopRepos(){
        let count = presenter.profileView.topRepositories.count + 3
        let repos =  presenter.loadMoreTopRepors()
        XCTAssert(repos.count == count)
        
    }
    func test_C_LoadMoreStartRepos(){
        let count = presenter.profileView.startedRepositories.count + 3
        let repos =  presenter.loadMoreStartedRepors()
        XCTAssert(repos.count == count)
        
    }
    func test_D_ViewAllPinnedRepos(){
        
        let repos =  presenter.viewAllTopRepors()
        
        XCTAssert(repos.count == 9)
        
    }
    
    func test_E_ViewAllTopRepos(){
        
        let repos =  presenter.viewAllTopRepors()
        
        XCTAssert(repos.count == 9)
        
    }
    
    func test_F_ViewAllStarRepos(){
        
        let repos =  presenter.viewAllStartedRepors()
        
        XCTAssert(repos.count == 9)
        
    }
}
