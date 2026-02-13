//
//  SpyNavigationController.swift
//  PhotoAppTests
//
//  Created by Manan Devani on 11/02/26.
//

import UIKit

class SpyNavigationController: UINavigationController {
    
    var pushedController: UIViewController!
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        pushedController = viewController
    }
}
