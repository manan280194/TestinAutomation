//
//  MockSignupPresenter.swift
//  PhotoAppTests
//
//  Created by Manan Devani on 10/02/26.
//

import Foundation
@testable import PhotoApp

class MockSignupPresenter: SignupPresenterProtocol {
    
    var isProcessSignupCalled = false
    
    func processUserSignup(formModel: PhotoApp.SignupFormModel) {
        isProcessSignupCalled = true
    }
    
    required init(formModelValidator: PhotoApp.SignupModelValidatorProtocol, webService: PhotoApp.SignupWebServiceProtocol, viewDelegate: PhotoApp.SignupViewDelegateProtocol) {
        // TODO: - Init testing pending.
    }
}
