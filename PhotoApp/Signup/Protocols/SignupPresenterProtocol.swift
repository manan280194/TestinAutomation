//
//  SignupPresenterProtocol.swift
//  PhotoApp
//
//  Created by Manan Devani on 10/02/26.
//

import Foundation

protocol SignupPresenterProtocol {
    init(formModelValidator: SignupModelValidatorProtocol, webService: SignupWebServiceProtocol, viewDelegate: SignupViewDelegateProtocol)
    func processUserSignup(formModel: SignupFormModel)
}
