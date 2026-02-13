//
//  SignupWebService.swift
//  PhotoApp
//
//  Created by Manan Devani on 04/02/26.
//

import Foundation

class SignupWebService: SignupWebServiceProtocol {
    
    private let urlSession: URLSession
    private let urlString: String
    
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func signup(withForm formModel: SignupFormRequestModel, completionHandler: @escaping (SignupResponseModel?, SignupError?) -> Void) {
        // URL
        guard let url = URL(string: urlString) else {
            completionHandler(nil, SignupError.invalidRequestURLString)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("Xcode-Test-App", forHTTPHeaderField: "User-Agent")
        urlRequest.httpBody = try? JSONEncoder().encode(formModel)
        
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completionHandler(nil, SignupError.failedRequest(description: error.localizedDescription))
                return
            }
            
            if let data = data, var responseModel = try? JSONDecoder().decode(SignupResponseModel.self, from: data) {
                responseModel.status = "ok"
                completionHandler(responseModel, nil)
            } else {
                completionHandler(nil, SignupError.invalidResponseModel)
                return
            }
        }
        
        task.resume()
    }
}
