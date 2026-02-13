//
//  SignupPresenterTests.swift
//  PhotoAppTests
//
//  Created by Manan Devani on 07/02/26.
//

import XCTest
@testable import PhotoApp

final class SignupPresenterTests: XCTestCase {
    var signupFormModel: SignupFormModel!
    var mockSignupModelValidator:MockSignupModelValidator!
    var mockSignupWebService: MockSignupWebService!
    var mockSignupViewDelegate: MockSignupViewDelegate!
    var sut: SignupPresenter!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        signupFormModel = SignupFormModel(
            firstName: "Manan",
            lastName: "Devani",
            email: "test@test.com",
            mobile: "9876543210",
            password: "12345678",
            repeatPassword: "12345678"
        )
        
        mockSignupModelValidator = MockSignupModelValidator()
        mockSignupWebService = MockSignupWebService()
        mockSignupViewDelegate = MockSignupViewDelegate()
        sut = SignupPresenter(formModelValidator: mockSignupModelValidator, webService: mockSignupWebService, viewDelegate: mockSignupViewDelegate)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        signupFormModel = nil
        mockSignupModelValidator = nil
        mockSignupWebService = nil
        mockSignupViewDelegate = nil
        sut = nil
    }
    
    func testSignupPresenter_WhenInformationProvided_WillValidateEachProperty() {
        // Arrange - Done in Setup()
        
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        
        // Assert
        XCTAssertTrue(mockSignupModelValidator.isFirstNameValidated, "First name was not validated.")
        XCTAssertTrue(mockSignupModelValidator.isLastNameValidated, "Last name was not validated.")
        XCTAssertTrue(mockSignupModelValidator.isEmailAddressValidated, "Email address was not validated.")
        XCTAssertTrue(mockSignupModelValidator.isPasswordValidated, "Password was not validated.")
        XCTAssertTrue(mockSignupModelValidator.doPasswordsMatchValidated, "Password and repeat password match was not validated.")
    }
    
    func testSignupPresenter_WhenValidDataProvided_CallSignupMethod() {
        // Arrange - Done in Setup()
        
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        
        // Assert
        XCTAssertTrue(mockSignupWebService.isSignupMethodCalled, "The signup() method was not called in the SignupWebService class")
    }
    
    func testSignupPresenter_WhenSignupOperationSuccessfull_ShouldCallSuccessOnViewDelegate() {
        // Arrange
        let myExpectation = expectation(description: "Expected successfullSignup() to be called")
        mockSignupViewDelegate.myExpectation = myExpectation
        
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        wait(for: [myExpectation], timeout: 5)
        
        // Assert
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 1, "The successfulSignup() methods was called more then once.")
    }
    
    func testSignupPresenter_WhenSignupOperationFailed_ShouldCallErrorHandlerOnViewDelegate() {
        // Arrange
        let myExpectation = expectation(description: "Expected errorHandler() to be called")
        mockSignupViewDelegate.myExpectation = myExpectation
        mockSignupWebService.callError = true
        
        // Act
        sut.processUserSignup(formModel: signupFormModel)
        wait(for: [myExpectation], timeout: 5)
        
        // Assert
        XCTAssertEqual(mockSignupViewDelegate.successfulSignupCounter, 0)
        XCTAssertEqual(mockSignupViewDelegate.errorSignupCounter, 1)
        XCTAssertNotNil(mockSignupViewDelegate.signupError)
    }
}
