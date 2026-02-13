//
//  SignupWebServiceTests.swift
//  PhotoAppTests
//
//  Created by Manan Devani on 04/02/26.
//

import XCTest
@testable import PhotoApp

final class SignupWebServiceTests: XCTestCase {
    
    var sut: SignupWebService!
    var signupFormRequestModel: SignupFormRequestModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        
        sut = SignupWebService(urlString: SignupConstants.signupURLString, urlSession: urlSession)
        
        signupFormRequestModel = SignupFormRequestModel(
            firstName: "Manan",
            lastName: "Devani",
            email: "test@test.com",
            password: "12345678"
        )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sut = nil
        signupFormRequestModel = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnsSuccess() {
        // Arrange
        let jsonString = "{\"status\": \"ok\", \"id\": 11}"
        let data = jsonString.data(using: .utf8)
        MockURLProtocol.stubResponseData = data
        
        let expectation = self.expectation(description: "Sign up response model success expectation")
        
        // Act
        sut.signup(withForm: signupFormRequestModel) { signupResponseModel, error in
         
            // Assert
            XCTAssertEqual(signupResponseModel?.status, "ok", "Status mismatch, expected \"ok\" and received \(signupResponseModel!.status)")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenDifferentJSONResponseReceived_ErrorParse() {
        // Arrange
        let jsonString = "{\"path\":\"/users\", \"error\":\"Internal Server Error\"}"
        let data = jsonString.data(using: .utf8)
        MockURLProtocol.stubResponseData = data
        
        let expectation = self.expectation(description: "Sign up method expectation for a response that contains different JSON structure")
        
        // Act
        sut.signup(withForm: signupFormRequestModel) { signupResponseModel, error in
         
            // Assert
            XCTAssertNil(signupResponseModel, "Expected nil for response model, received some data")
            XCTAssertEqual(error!, SignupError.invalidResponseModel, "Expected invalidResponseModel, received different error")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testSignupWebService_WhenEmptyURLStringProvided_ReturnError() {
        // Arrange
        let expectation = self.expectation(description: "An empty request URL String expectation")
        sut = SignupWebService(urlString: "")
        
        // Act
        sut.signup(withForm: signupFormRequestModel) { signupResponseModel, error in
            // Assert
            XCTAssertEqual(error, SignupError.invalidRequestURLString)
            XCTAssertNil(signupResponseModel, "When invalidRequestURLString error takes place, the response model must be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testSignupWebService_WhenRequestFails_ReturnsErrorDescription() {
        // Arrange
        let expectation = self.expectation(description: "A failed request expectation")
        let errorDescription = "A localised description of an error"
//        MockURLProtocol.error = SignupError.failedRequest(description: errorDescription)
        MockURLProtocol.error = NSError(domain: "com.test", code: -1, userInfo: [NSLocalizedDescriptionKey: errorDescription])
        
        // Act
        sut.signup(withForm: signupFormRequestModel) { signupResponseModel, error in
            XCTAssertEqual(error, SignupError.failedRequest(description: errorDescription))
            expectation.fulfill()
        }
        
        // Assert
        self.wait(for: [expectation], timeout: 2)
    }
}
