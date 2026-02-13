//
//  SignupViewControllerTests.swift
//  PhotoAppTests
//
//  Created by Manan Devani on 10/02/26.
//

import XCTest
@testable import PhotoApp

final class SignupViewControllerTests: XCTestCase {
    
    var storyboard: UIStoryboard!
    var sut: SignupViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: "SignupViewController") as SignupViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSignupViewController_WhenCreated_TextFieldsShouldBeEmpty() throws {
        // Arrange - In Setup
        // Act - Initial State Check
        // Assert
        
        let firstNameTextField = try XCTUnwrap(sut.firstNameTextField, "Text field firstNameTextField is not connected to the IBOutlet")
        let lastNameTextField = try XCTUnwrap(sut.lastNameTextField, "Text field lastNameTextField is not connected to the IBOutlet")
        let emailTextField = try XCTUnwrap(sut.emailTextField, "Text field emailTextField is not connected to the IBOutlet")
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "Text field passwordTextField is not connected to the IBOutlet")
        let repeatPasswordTextField = try XCTUnwrap(sut.repeatPasswordTextField, "Text field repeatPasswordTextField is not connected to the IBOutlet")
        
        XCTAssertEqual(firstNameTextField.text, "", "First Name Text field was not empty when view controller initially loaded.")
        XCTAssertEqual(lastNameTextField.text, "", "Last Name Text field was not empty when view controller initially loaded.")
        XCTAssertEqual(emailTextField.text, "", "Email Text field was not empty when view controller initially loaded.")
        XCTAssertEqual(passwordTextField.text, "", "Password Text field was not empty when view controller initially loaded.")
        XCTAssertEqual(repeatPasswordTextField.text, "", "Repeat Password Text field was not empty when view controller initially loaded.")
    }
    
    func testSignupViewController_WhenCreated_HasSignupButtonAndAction() throws {
        // Arrange
        let signupButton = try XCTUnwrap(sut.signupButton, "Signup button is not connected with IBOutlet")
        
        // Act
        let actions = try XCTUnwrap(signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside), "signupButton does not contain actions")
        
        // Assert
        XCTAssertEqual(actions.count, 1, "signupButton does not have exactly one connection")
        XCTAssertEqual(actions.first, "signupButtonTapped:", "Signup button does not have action signupButtonTap")
        
    }
    
    func testSignupViewController_WhenSignupButtonTapped_InvokesSignupProcess() {
        // Arrange
        let mockSignupModelValidator = MockSignupModelValidator()
        let mockSignupWebService = MockSignupWebService()
        let mockSignupViewDelegate = MockSignupViewDelegate()
        
        let mockSignupPresenter = MockSignupPresenter(formModelValidator: mockSignupModelValidator, webService: mockSignupWebService, viewDelegate: mockSignupViewDelegate)
        sut.signupPresenter = mockSignupPresenter
        
        // Act
        sut.signupButton.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssertTrue(mockSignupPresenter.isProcessSignupCalled, "The processUserSignup() method was not called on presenter when signupButtonTapped from SignupViewController.")
    }
    
    func testEmailTextField_WhenViewControllerCreated_ContentTypeIsEmailAddress() throws {
        // Arrange
        let emailTextField = try XCTUnwrap(sut.emailTextField, "Email address text field is not connected.")
        
        // Act - None
        // Assert
        XCTAssertEqual(emailTextField.textContentType, .emailAddress, "ContentType of emailTextField is not set to emailAddress.")
    }
    
    func testEmailTextField_WhenCreated_HasEmailKeyboardTypeSet() throws {
        // Arrange
        let emailTextField = try XCTUnwrap(sut.emailTextField, "Email address text field is not connected.")
        
        // Act - None
        // Assert
        XCTAssertEqual(emailTextField.keyboardType, .emailAddress, "Keyboard type of emailTextField is not set to emailAddress.")
    }
    
    func testPasswordTextField_WhenCreated_ShouldHaveSecureTextEntry() throws {
        // Arrange
        let passwordTextField = try XCTUnwrap(sut.passwordTextField, "Password text field is not connected.")
        
        // Act - None
        // Assert
        XCTAssertTrue(passwordTextField.isSecureTextEntry, "Password text field secure entry is not set to true.")
    }
}
