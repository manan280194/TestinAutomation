//
//  SignupPresenter.swift
//  PhotoApp
//
//  Created by Manan Devani on 07/02/26.
//

import Foundation

class SignupPresenter: SignupPresenterProtocol {
    private let formModelValidator: SignupModelValidatorProtocol
    private let webService: SignupWebServiceProtocol
    private weak var viewDelegate: SignupViewDelegateProtocol?
    
    required init(formModelValidator: SignupModelValidatorProtocol, webService: SignupWebServiceProtocol, viewDelegate: SignupViewDelegateProtocol) {
        self.formModelValidator = formModelValidator
        self.webService = webService
        self.viewDelegate = viewDelegate
    }
    
    func processUserSignup(formModel: SignupFormModel) {
        if !formModelValidator.isFirstNameValid(formModel.firstName) {
            viewDelegate?.errorHandler(error: SignupError.invalidFirstName)
            return
        }
        
        if !formModelValidator.isLastNameValid(formModel.lastName) {
            viewDelegate?.errorHandler(error: SignupError.invalidLastName)
            return
        }
        
        if !formModelValidator.isEmailAddressValid(formModel.email) {
            viewDelegate?.errorHandler(error: SignupError.invalidEmail)
            return
        }
        
        if !formModelValidator.isMobileNumberValid(formModel.mobile) {
            viewDelegate?.errorHandler(error: SignupError.invalidMobileNumber)
            return
        }
        
        if !formModelValidator.isPasswordValid(formModel.password) {
            viewDelegate?.errorHandler(error: SignupError.invalidPassword)
            return
        }
        
        if !formModelValidator.doPasswordsMatch(pass: formModel.password, repeatPass: formModel.repeatPassword) {
            viewDelegate?.errorHandler(error: SignupError.passwordsDoNotMatch)
            return
        }
        
        webService.signup(withForm: .init(firstName: formModel.firstName, lastName: formModel.lastName, email: formModel.email, password: formModel.password)) { [weak self] responseModel, errorObject in
            if let _ = responseModel {
                self?.viewDelegate?.successfulSignup()
                return
            }
            if let errorObject = errorObject {
                self?.viewDelegate?.errorHandler(error: errorObject)
                return
            }
        }
    }
}
