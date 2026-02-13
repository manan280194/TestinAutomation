//
//  SignupError.swift
//  PhotoApp
//
//  Created by Manan Devani on 04/02/26.
//

import Foundation

enum SignupError: Error, LocalizedError, Equatable {
    case invalidResponseModel
    case invalidRequestURLString
    case failedRequest(description: String)
    case invalidFirstName
    case invalidLastName
    case invalidEmail
    case invalidMobileNumber
    case invalidPassword
    case passwordsDoNotMatch
    
    var errorDescription: String? {
        switch self {
        case .invalidResponseModel, .invalidRequestURLString:
            return ""
        case .failedRequest(let description):
            return description
        case .invalidFirstName:
            return "Invalid First name"
        case .invalidLastName:
            return "Invalid Last name"
        case .invalidEmail:
            return "Invalid Email"
        case .invalidMobileNumber:
            return "Invalid Mobile Number"
        case .invalidPassword:
            return "Invalid Password"
        case .passwordsDoNotMatch:
            return "Password and Repeat Passwords does not match."
        }
    }
}

enum SignupValidationError: Error {
    case illegalCharacterFound
    case unmatchedCharacter
}
