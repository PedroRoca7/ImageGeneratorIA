//
//  APIMock.swift
//  ImageGeneratorIATests
//
//  Created by Pedro Henrique on 21/06/23.
//

import Foundation
@testable import ImageGeneratorIA

struct APIMock: APIProtocol {
    
    let fail: Bool
    
    func sendOpenAIRequest(text: String, completion: @escaping (Result<String, ImageGeneratorIA.OpenAIError>) -> Void) {
        if fail {
            completion(.failure(.missingChoicesText))
        } else {
            completion(.success("Ok"))
        }
    }
    
    
}
