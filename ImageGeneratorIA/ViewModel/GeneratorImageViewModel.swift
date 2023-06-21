//
//  GeneratorImageManager.swift
//  ImageGeneratorIA
//
//  Created by Pedro Henrique on 18/05/23.
//

import Foundation
import UIKit

protocol GeneratorImageViewModelProtocol: AnyObject {
    func success()
    func failure()
    func confirmationAlert()
}

class GeneratorImageViewModel {
    
    var api: APIProtocol = API()
    var url: String?
    var testApiMock: String?
    weak var delegate: GeneratorImageViewModelProtocol?
    
    func requestImage(text: String) -> Void {
        api.sendOpenAIRequest(text: text) { result in
            switch result {
            case .success(let imageUrl):
                self.url = imageUrl
                self.delegate?.success()
                self.testApiMock = "Ok"
            case .failure(let error):
                self.delegate?.failure()
                self.testApiMock = "Erro"
                print(error)
            }
        }
    }

    func saveImageToGallery(imageView: UIImageView) {
        // Verifica se a imagem da ImageView é válida
        guard let image = imageView.image else {
            print("A ImageView não possui uma imagem válida.")
            return
        }

        // Salva a imagem na biblioteca de fotos
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.delegate?.confirmationAlert()
    }
}
