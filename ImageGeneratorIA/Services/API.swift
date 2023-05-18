//
//  API.swift
//  ImageGeneratorIA
//
//  Created by Pedro Henrique on 18/05/23.
//

import Foundation
import OpenAISwift

enum OpenAIError: Error {
case missingChoicesText
case apiError(Error)
}

class API {
    
    static let authToken: String = "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"
    var openAIModelType: OpenAIModelType = .gpt3(.davinci)
    var token: OpenAISwift = OpenAISwift(authToken: authToken)
    
    func sendOpenAIRequest(text: String, completion: @escaping (Result<String, OpenAIError>) -> Void) {
        token.sendImages(with: text, numImages: 1, size: .size1024) { result in
            switch result {
            case .success(let success):
                guard let text = success.data?.first?.url else {
                    completion(.failure(.missingChoicesText))
                    return }
                completion(.success(text))
            case .failure(let error):
                completion(.failure(.apiError(error)))
            }
        }
    }
}
