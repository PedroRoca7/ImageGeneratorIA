//
//  Extension.swift
//  ImageGeneratorIA
//
//  Created by Pedro Henrique on 31/05/23.
//

import Foundation
import UIKit

extension ViewController: GeneratorImageManagerProtocol {

    func success() {
        DispatchQueue.main.async {
            self.generatedImageView.isHidden = false
            guard let image = self.generator.url else { return }
            if let url = URL(string: image) {
                self.generatedImageView.kf.setImage(with: url)
                self.loadingActivity.isHidden = true
                self.downloadButton.isHidden = false
            }
        }

    }
    
    func failure() {
        self.generatedImageView.image = nil
        print("Erro")
    }
    
    func confirmationAlert() {
        
        // Exibe uma mensagem de confirmação
        let alertController = UIAlertController(title: "Sucesso", message: "A imagem foi salva na galeria.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        // Apresenta o alerta na tela
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first
        {
            window.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
}
