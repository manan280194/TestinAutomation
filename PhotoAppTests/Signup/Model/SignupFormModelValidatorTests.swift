//
//  SignupFormModelValidatorTests.swift
//  PhotoAppTests
//
//  Created by Manan Devani on 02/02/26.
//

import XCTest
@testable import PhotoApp

final class SignupFormModelValidatorTests: XCTestCase {
    
    var sut: SignupFormModelValidator!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SignupFormModelValidator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testSignupFormValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let isFirstNameValid = sut.isFirstNameValid("Sergey")
        
        // Assert
        XCTAssertTrue(isFirstNameValid, "The isFirstNameValid() should have returned TRUE for a valid first name. Instead, returned FALSE")
    }
    
    func testSignupFormValidator_WhenFirstNameTooShort_ShouldReturnFalse() {
        // Act
        let isFirstNameValid = sut.isFirstNameValid("S")
        
        // Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned FALSE that is less than \(SignupConstants.firstNameMinLength) characters. Instead, returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenFirstNameTooLong_ShouldReturnFalse() {
        // Act
        let isFirstNameValid = sut.isFirstNameValid("SergeySergey")
        
        // Assert
        XCTAssertFalse(isFirstNameValid, "The isFirstNameValid() should have returned FALSE that is greater than \(SignupConstants.firstNameMaxLength) characters. Instead, returned TRUE")
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testSignupFormModelValidator_WhenLastNameValid_ShouldReturnTrue() {
        // Arrange
        // Act
        let result = sut.isLastNameValid("Devani")
        // Assert
        XCTAssertTrue(result, "Is isLastNameValid func should have returned TRUE for valid Last Name. Instead returned FALSE")
    }
    
    func testSignupFormModelValidator_WhenLastNameTooShort_ShouldReturnFalse() {
        // Arrange
        // Act
        let result = sut.isLastNameValid("D")
        // Assert
        XCTAssertFalse(result, "isLastNameValid func should have returned FALSE for Last name shorter then \(SignupConstants.lastNameMinLength) characters. Instead returned TRUE.")
    }
    
    
    func testSignupFormModelValidator_WhenLastNameTooLong_ShouldReturnFalse() {
        // Arrange
        // Act
        let result = sut.isLastNameValid("DevaniDevaniDevani")
        // Assert
        XCTAssertFalse(result, "isLastNameValid func should have returned FALSE for Last name longer then \(SignupConstants.lastNameMaxLength) characters. Instead returned TRUE.")
    }
    
    func testSignupFormModelValidator_WhenEmailIsValid_ShouldReturnTrue() {
        // Arrange - Setup, TearDown arranged.
        // Act
        let result = sut.isEmailAddressValid("manan.devani@biz4solutions.com")
        // Assert
        XCTAssertTrue(result, "isEmailAddressValid func should have returned TRUE for valid email address. Instead returned FALSE")
    }
    
    func testSignupFormModelValidator_WhenEmailIsInValid_ShouldReturnTrue() {
        // Arrange - Setup, TearDown arranged.
        // Act
        let result = sut.isEmailAddressValid("manandevanibiz4solutionscom")
        // Assert
        XCTAssertFalse(result, "isEmailAddressValid func should have returned FALSE for invalid email address. Instead returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenEmailIsTooShort_ShouldReturnFalse() {
        // Arrange - Setup, TearDown arranged.
        // Act
        let result = sut.isEmailAddressValid("m@g.")
        // Assert
        XCTAssertFalse(result, "isEmailAddressValid func should have returned FALSE for Email Address shorter then \(SignupConstants.emailMinLength) characters. Instead returned TRUE.")
    }
    
    func testSignupFormModelValidator_WhenEmailIsTooLong_ShouldReturnFalse() {
        // Arrange - Setup, TearDown arranged.
        // Act
        let result = sut.isEmailAddressValid("manan.devani@biz4solutions.commanan.devani@biz4solutions.commanan.devani@biz4solutions.commanan.devani@biz4solutions.com")
        // Assert
        XCTAssertFalse(result, "isEmailAddressValid func should have returned FALSE for Email Address longer then \(SignupConstants.emailMaxLength) characters. Instead returned TRUE.")
    }

    
    func testSignupFormValidator_WhenValidPasswordProvided_ShouldReturnTrue() {
        // Arrange
        // Act
        let isPasswordValid = sut.isPasswordValid("12345678")
        
        // Assert
        XCTAssertTrue(isPasswordValid, "The isPasswordValid() should have returned TRUE for a valid password. Instead, returned FALSE")
    }
    
    func testSignupFormValidator_WhenPasswordTooShort_ShouldReturnFalse() {
        // Act
        let isPasswordValid = sut.isPasswordValid("1")

        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should have returned FALSE that is less than \(SignupConstants.passwordMinLength) characters. Instead, returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenPasswordTooLong_ShouldReturnFalse() {
        // Act
        let isPasswordValid = sut.isPasswordValid("12345678123456781234567812345678")

        // Assert
        XCTAssertFalse(isPasswordValid, "The isPasswordValid() should have returned FALSE that is greater than \(SignupConstants.passwordMaxLength) characters. Instead, returned TRUE")
    }
    
    func testSignupFormModelValidator_WhenSamePasswordProvided_ShouldReturnTrue() {
        // Act
        let doPasswordsMatch = sut.doPasswordsMatch(pass: "12345678", repeatPass: "12345678")
        
        // Assert
        XCTAssertTrue(doPasswordsMatch, "The doPasswordsMatch func returned False even though matching passwords were provided.")
    }
    
    func testSignupFormModelValidator_WhenNotEqualPasswordsProvided_ShouldReturnFalse() {
        // Act
        let doPasswordsMatch = sut.doPasswordsMatch(pass: "12345678", repeatPass: "1234678")
        
        // Assert
        XCTAssertFalse(doPasswordsMatch, "The doPasswordsMatch() should have returned False when not equal passwords provided but returned True.")
    }
    
    func testFirstNameValidation_WhenIllegalCharacterDetected_ThrowsError() {
        // Arrange - At global
        // Act and Assert
        XCTAssertThrowsError(try sut.firstNameInvalidCharacterValidation("Manan*"), "Should have thrown error, did not throw, when first name contained illegal character") { error in
            XCTAssertEqual(error as? SignupValidationError, .illegalCharacterFound, "Thrown unexpected error \(error as? SignupValidationError), instead of illegalCharacterError")
        }
    }
    
    func testFirstNameValidation_WhenIllegalCharacterDetected_ThrowsErrorDTC() {
        // Arrange - At global
        // Act and Assert
        do {
            _ = try sut.firstNameInvalidCharacterValidation("Manan*")
            XCTFail("Should have thrown error, did not throw, when first name contained illegal character")
        } catch SignupValidationError.illegalCharacterFound {
            // As expected - Pass
            return
        } catch {
            XCTFail("Thrown unexpected error \(error as? SignupValidationError), instead of illegalCharacterError")
        }
    }
    
    func testFirstNameValidation_WhenValidCharactersProvided_NoErrorThrown() {
        // Arrange - At class level
        
        // Act and Assert
        XCTAssertNoThrow(try sut.firstNameInvalidCharacterValidation("Manan"), "Thrown error when first name was valid.")
    }
    
    func testFirstNameValidation_WhenValidCharactersProvided_NoErrorThrownDTC() {
        // Arrange - At global
        // Act and Assert
        do {
            _ = try sut.firstNameInvalidCharacterValidation("Manan")
        } catch {
            XCTFail("Thrown error when first name was valid.")
        }
    }
}

/*
 func testSignupFormModelValidator_WhenPasswordIsValid_ShouldReturnTrue() {
     // Arrange - Setup, TearDown arranged.
     // Act
     // Assert
 }
 */
