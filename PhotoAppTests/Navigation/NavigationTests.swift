//
//  NavigationTests.swift
//  PhotoAppTests
//
//  Created by Manan Devani on 11/02/26.
//

import XCTest
@testable import PhotoApp

final class NavigationTests: XCTestCase {

    var sut: SignupViewController!
    var navigationController: UINavigationController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController
        sut.loadViewIfNeeded()
        
        navigationController = UINavigationController(rootViewController: sut)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testNextButton_WhenTapped_NavigateToSecondController() {
        // Arrange
        let predicate = NSPredicate { (inputObject, nil) in
            (inputObject as? UINavigationController)?.topViewController is SecondViewController
        }
        let expectation = expectation(for: predicate, evaluatedWith: navigationController)
        
        // Act
        sut.nextButton.sendActions(for: .touchUpInside)
        
        // Assert
        wait(for: [expectation], timeout: 1.5)
    }
    
    
    func testNextButton_WhenTapped_NavigateToSecondControllerV2() {
        // Arrange
        
        // Act
        sut.nextButton.sendActions(for: .touchUpInside)
        
        RunLoop.current.run(until: Date())
        
        // Assert
        guard let _ = navigationController.topViewController as? SecondViewController else {
            XCTFail()
            return
        }
    }
    
    func testNextButton_WhenTapped_NavigateToSecondControllerV3() {
        // Arrange
        let spyNavigationController = SpyNavigationController(rootViewController: sut)
        
        // Act
        sut.nextButton.sendActions(for: .touchUpInside)
        
        // Assert
        guard let _ = spyNavigationController.pushedController as? SecondViewController else {
            XCTFail()
            return
        }
    }
}
