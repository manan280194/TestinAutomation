//
//  MockSignupViewDelegate.swift
//  PhotoAppTests
//
//  Created by Manan Devani on 09/02/26.
//

import Foundation
@testable import PhotoApp
import XCTest

class MockSignupViewDelegate: SignupViewDelegateProtocol {
    
    var myExpectation: XCTestExpectation?
    var successfulSignupCounter: Int = 0
    var errorSignupCounter: Int = 0
    var signupError: SignupError?
    
    func successfulSignup() {
        successfulSignupCounter += 1
        myExpectation?.fulfill()
    }
    
    func errorHandler(error: SignupError) {
        signupError = error
        errorSignupCounter += 1
        myExpectation?.fulfill()
    }
}
