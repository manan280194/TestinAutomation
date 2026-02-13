//
//  SignupViewController.swift
//  PhotoApp
//
//  Created by Manan Devani on 10/02/26.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var signupPresenter: SignupPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if signupPresenter == nil {
            let signupFormValidator = SignupFormModelValidator()
            let signupWebService = SignupWebService(urlString: SignupConstants.signupURLString)
            
            signupPresenter = SignupPresenter(formModelValidator: signupFormValidator, webService: signupWebService, viewDelegate: self)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signupButtonTapped(_ sender: UIButton) {
        signupPresenter.processUserSignup(formModel: .init(firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", email: emailTextField.text ?? "", mobile: mobileTextField.text ?? "", password: passwordTextField.text ?? "", repeatPassword: repeatPasswordTextField.text ?? ""))
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let secondViewController = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else { return }
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}

extension SignupViewController: SignupViewDelegateProtocol {
    func successfulSignup() {
        let alertController = UIAlertController(title: "Success", message: "Signup Operation Successfull", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default) { action in
            
        }
        alertController.addAction(alertAction)
        DispatchQueue.main.async {
            alertController.view.accessibilityIdentifier = "successAlertDialog"
            self.present(alertController, animated: true)
        }
    }
    
    func errorHandler(error: SignupError) {
        let alertController = UIAlertController(title: "Validation Error", message: "Could not proceed. Please check the error: \(error.localizedDescription)", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default) { action in
            
        }
        alertController.addAction(alertAction)
        
        DispatchQueue.main.async {
            alertController.view.accessibilityIdentifier = "errorAlertDialog"
            self.present(alertController, animated: true)
        }
    }
    
    
}
