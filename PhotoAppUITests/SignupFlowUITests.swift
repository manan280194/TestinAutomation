//
//  SignupFlowUITests.swift
//  SignupFlowUITests
//
//  Created by Manan Devani on 11/02/26.
//

import XCTest

final class SignupFlowUITests: XCTestCase {
    
    var app: XCUIApplication!
    var firstName: XCUIElement!
    var lastName: XCUIElement!
    var email: XCUIElement!
    var mobileNumber: XCUIElement!
    var password: XCUIElement!
    var repeatPassword: XCUIElement!
    var signupButton: XCUIElement!
    var nextButton: XCUIElement!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        

        // Act
        app = XCUIApplication()
        app.launchArguments = ["--skipLogin"]
        app.launch()
        
        /// Navigate to Signup
//        app.buttons["CreateAccountButton"].tap()
        
        firstName = app.textFields["firstNameTextField"]
        lastName = app.textFields["lastNameTextField"]
        email = app.textFields["emailAddressTextField"]
        mobileNumber = app.textFields["mobileNumberTextField"]
        password = app.secureTextFields["passwordTextField"]
        repeatPassword = app.secureTextFields["repeatPasswordTextField"]
        signupButton = app.buttons["signupButton"]
        nextButton = app.buttons["nextButton"]
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func testSignupViewController_WhenDidLoad_ElementsShouldBeEnabled() throws {
        // UI tests must launch the application that they test.
        
        XCTAssertTrue(firstName.isEnabled, "First Name UITextField is not enabled for user interactions.")
        XCTAssertTrue(lastName.isEnabled, "Last Name UITextField is not enabled for user interactions.")
        XCTAssertTrue(email.isEnabled, "Email UITextField is not enabled for user interactions.")
        XCTAssertTrue(mobileNumber.isEnabled, "Mobile Number UITextField is not enabled for user interactions.")
        XCTAssertTrue(password.isEnabled, "Password Secure UITextField is not enabled for user interactions.")
        XCTAssertTrue(repeatPassword.isEnabled, "Repeat Password Secure UITextField is not enabled for user interactions.")
        XCTAssertTrue(signupButton.isEnabled, "SignupButton is not enabled for user interactions.")
        XCTAssertTrue(nextButton.isEnabled, "NextButton is not enabled for user interactions.")
    }
    
    func testSignupViewController_WhenInvalidFormSubmitted_PresentErrorAlertDialog() {
        XCTAssertTrue(firstName.waitForExistence(timeout: 5), "Signup screen did not load in time.")
        
        // Arrange
        firstName.tap()
        firstName.typeText("M")
        
        lastName.tap()
        lastName.typeText("D")
        
        email.tap()
        email.typeText("@")
        
        mobileNumber.tap()
        mobileNumber.typeText("987")
        
        password.tap()
        password.typeText("123456")
        
        repeatPassword.tap()
        repeatPassword.typeText("123")
        
        // Act
        signupButton.tap()
        
        // Assert
        XCTAssertTrue(app.alerts["errorAlertDialog"].waitForExistence(timeout: 1), "An Error alert dialog was not present when invalid form was submitted.")
    }
    
    func testSignupViewController_WhenValidFormSubmitted_PresentSuccessAlertDialog() {
        XCTAssertTrue(firstName.waitForExistence(timeout: 5), "Signup screen did not load in time.")
        
        // Arrange
        firstName.tap()
        firstName.typeText("Manan")
        
        lastName.tap()
        lastName.typeText("Devani")
        
        email.tap()
        email.typeText("test@test.com")
        
        mobileNumber.tap()
        mobileNumber.typeText("9876543210")
        
        password.tap()
        password.typeText("12345678")
        
        repeatPassword.tap()
        repeatPassword.typeText("12345678")
        
        // Act
        signupButton.tap()
        
        // Assert
        XCTAssertTrue(app.alerts["successAlertDialog"].waitForExistence(timeout: 5), "A Success alert dialog was not present when valid form was submitted.")
    }
    
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
