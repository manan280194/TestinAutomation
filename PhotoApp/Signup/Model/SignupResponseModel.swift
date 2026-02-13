//
//  SignupResponseModel.swift
//  PhotoApp
//
//  Created by Manan Devani on 04/02/26.
//

import Foundation

struct SignupResponseModel: Decodable {
    var status: String = "Unknown"
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
