//
//  MockSignupWebService.swift
//  PhotoAppTests
//
//  Created by Manan Devani on 09/02/26.
//

import Foundation
@testable import PhotoApp

class MockSignupWebService: SignupWebServiceProtocol {
    
    var isSignupMethodCalled = false
    var callError = false
     
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        isSignupMethodCalled = true
        if callError {
            completionHandler(nil, SignupError.failedRequest(description: "Manually Failed Request"))
        } else {
            completionHandler(SignupResponseModel(status: "ok", id: 11), nil)
        }
    }
}
