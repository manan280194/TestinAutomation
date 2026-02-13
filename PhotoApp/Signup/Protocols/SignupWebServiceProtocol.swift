//
//  SignupWebServiceProtocol.swift
//  PhotoApp
//
//  Created by Manan Devani on 09/02/26.
//

import Foundation

protocol SignupWebServiceProtocol {
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void)
}
