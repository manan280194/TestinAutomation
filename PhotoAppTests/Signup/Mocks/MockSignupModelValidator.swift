//
//  MockSignupModelValidator.swift
//  PhotoAppTests
//
//  Created by Manan Devani on 07/02/26.
//

import Foundation
@testable import PhotoApp

class MockSignupModelValidator: SignupModelValidatorProtocol {
    
    var isFirstNameValidated: Bool = false
    var isLastNameValidated: Bool = false
    var isEmailAddressValidated: Bool = false
    var isMobileNumberValidated: Bool = false
    var isPasswordValidated: Bool = false
    var doPasswordsMatchValidated: Bool = false
    
    func isFirstNameValid(_ firstName: String) -> Bool {
        isFirstNameValidated = true
        return isFirstNameValidated
    }
    
    func isLastNameValid(_ lastName: String) -> Bool {
        isLastNameValidated = true
        return isLastNameValidated
    }
    
    func isEmailAddressValid(_ emailAddress: String) -> Bool {
        isEmailAddressValidated = true
        return isEmailAddressValidated
    }
    
    func isMobileNumberValid(_ mobileNumber: String) -> Bool {
        isMobileNumberValidated = true
        return isMobileNumberValidated
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        isPasswordValidated = true
        return isPasswordValidated
    }
    
    func doPasswordsMatch(pass: String, repeatPass: String) -> Bool {
        doPasswordsMatchValidated = true
        return doPasswordsMatchValidated
    }
}
