//
//  SignupViewDelegateProtocol.swift
//  PhotoApp
//
//  Created by Manan Devani on 09/02/26.
//

import Foundation

protocol SignupViewDelegateProtocol: AnyObject {
    func successfulSignup()
    func errorHandler(error: SignupError)
}
