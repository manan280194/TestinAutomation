//
//  Localization.swift
//  PhotoApp
//
//  Created by Manan Devani on 13/02/26.
//

import Foundation


extension String {
    func localizedString() -> String {
        return NSLocalizedString(self, bundle: .main, comment: "")
    }
}

struct StringConstants {
    static let createAccount = "create_account"
}
