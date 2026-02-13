//
//  LoginViewController.swift
//  PhotoApp
//
//  Created by Manan Devani on 11/02/26.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.setTitle(StringConstants.createAccount.localizedString(), for: .normal)
        
    }
    
    @IBAction func didTapOnCreateAccount(_ sender: UIButton) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let signupViewController = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        
        signupViewController.view.accessibilityIdentifier = "SignupViewController"
        present(signupViewController, animated: true)
    }
}
