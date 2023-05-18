//
//  GeneratorImageManager.swift
//  ImageGeneratorIA
//
//  Created by Pedro Henrique on 18/05/23.
//

import Foundation

class GeneratorImageManager {
    
    let api: API = API()
    var url: String?
    
    func requestImage(text: String, completionHandler: @escaping (Bool) -> Void) {
        api.sendOpenAIRequest(text: text) { result in
            switch result {
            case .success(let imageUrl):
                self.url = imageUrl
                completionHandler(true)
            case .failure(let error):
                completionHandler(false)
                print(error)
            }
        }
    }
}
