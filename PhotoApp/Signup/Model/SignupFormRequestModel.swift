//
//  SignupFormRequestModel.swift
//  PhotoApp
//
//  Created by Manan Devani on 04/02/26.
//

import Foundation

struct SignupFormRequestModel: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case password = "password"
    }
}
