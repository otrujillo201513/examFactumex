//
//  ApiServices.swift
//  Factumex
//
//  Created by Macbook on 26/03/22.
//

import Foundation

protocol ServicesDelegate: AnyObject {
    func didLoadWith(data: InformationResponse)
    func didWithError(error: String)
}


class ApiServices {
    weak var delegate: ServicesDelegate?
    
    func fetchGraphics() {
        var request = URLRequest(url: URL(string: Constants.path.rawValue)!,timeoutInterval: Double.infinity)
        request.httpMethod = Constants.httpMethod.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _data = data {
                do {
                    let response = try JSONDecoder().decode(InformationResponse.self, from: _data)
                    DispatchQueue.main.async {
                        self.delegate?.didLoadWith(data: response)
                    }
                } catch _ {
                    DispatchQueue.main.async {
                        self.delegate?.didWithError(error: error?.localizedDescription ?? Constants.serviceFailure.rawValue)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.delegate?.didWithError(error: Constants.genericError.rawValue)
                }
            }
        }
        task.resume()
    }
}
