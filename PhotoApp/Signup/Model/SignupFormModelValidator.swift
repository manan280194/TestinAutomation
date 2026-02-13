//
//  SignupFormModelValidator.swift
//  PhotoApp
//
//  Created by Manan Devani on 02/02/26.
//

import Foundation

class SignupFormModelValidator: SignupModelValidatorProtocol {
    func isFirstNameValid(_ firstName: String) -> Bool {
        var returnValue = true
        if firstName.count < SignupConstants.firstNameMinLength || firstName.count > SignupConstants.firstNameMaxLength {
            returnValue = false
        }
        return returnValue
    }
    
    func isLastNameValid(_ lastName: String) -> Bool {
        if lastName.count < SignupConstants.lastNameMinLength || lastName.count > SignupConstants.lastNameMaxLength {
           return false
        }
        
        return true
    }
    
    func isEmailAddressValid(_ emailAddress: String) -> Bool {
        
        if emailAddress.count < SignupConstants.emailMinLength || emailAddress.count > SignupConstants.emailMaxLength {
            return false
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        return emailPred.evaluate(with: emailAddress)
    }
    
    func isMobileNumberValid(_ mobileNumber: String) -> Bool {
        guard mobileNumber.count == 10 else {
            return false
        }
        return true
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        if password.count < SignupConstants.passwordMinLength || password.count > SignupConstants.passwordMaxLength {
            return false
        }
        return true
    }
    
    func doPasswordsMatch(pass: String, repeatPass: String) -> Bool {
        return pass == repeatPass
    }
    
    func firstNameInvalidCharacterValidation(_ firstName: String) throws -> Bool {
        let characterSet = CharacterSet(charactersIn: "{}$#%*&^.,/?!@")
        
        if firstName.rangeOfCharacter(from: characterSet) != nil {
            throw SignupValidationError.illegalCharacterFound
        }
        
        if firstName.count < 2 || firstName.count > 10 {
            return false
        }
        
        return true
        
    }
}
