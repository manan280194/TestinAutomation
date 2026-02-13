//
//  SignupModelValidatorProtocol.swift
//  PhotoApp
//
//  Created by Manan Devani on 07/02/26.
//

import Foundation

protocol SignupModelValidatorProtocol {
    func isFirstNameValid(_ firstName: String) -> Bool
    
    func isLastNameValid(_ lastName: String) -> Bool
    
    func isEmailAddressValid(_ emailAddress: String) -> Bool
    
    func isMobileNumberValid(_ mobileNumber: String) -> Bool
    
    func isPasswordValid(_ password: String) -> Bool
    
    func doPasswordsMatch(pass: String, repeatPass: String) -> Bool
}
