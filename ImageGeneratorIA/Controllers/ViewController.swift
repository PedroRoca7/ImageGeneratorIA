//
//  ViewController.swift
//  ImageGeneratorIA
//
//  Created by Pedro Henrique on 18/05/23.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var generatedImageView: UIImageView!
    @IBOutlet weak var descriptionImageTextField: UITextField!
    @IBOutlet weak var generateImageButton: UIButton!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    @IBOutlet weak var aguardandoImageLabel: UILabel!
    @IBOutlet weak var bottomConstrain: NSLayoutConstraint!
    
    var generator = GeneratorImageManager()
    let pinkColor = UIColor(red: 230, green: 0, blue: 126, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingActivity.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        descriptionImageTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    
    }
    // Método chamado quando o teclado está prestes a aparecer
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // Obtenha a altura do teclado
            let keyboardHeight = keyboardSize.height
            
            // Atualize a constante de constraint vertical inferior com a altura do teclado
            bottomConstrain.constant = keyboardHeight
            
            // Animação da atualização da constraint
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // Método chamado quando o teclado está prestes a desaparecer
    @objc func keyboardWillHide(notification: NSNotification) {
        // Restaure a constante de constraint vertical inferior para o valor original
        bottomConstrain.constant = 0
        
        // Animação da atualização da constraint
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // Remove os observadores de notificação quando a view controller for destruída
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            generateImageButton.isEnabled = true
            generateImageButton.backgroundColor = pinkColor
        } else {
            generateImageButton.isEnabled = false
            generateImageButton.backgroundColor = .darkGray
        }
    }
    
    @IBAction func generateImage(_ sender: Any) {
        guard let text = descriptionImageTextField.text else { return }
        aguardandoImageLabel.isHidden = true
        loadingActivity.isHidden = false
        descriptionImageTextField.resignFirstResponder()
        descriptionImageTextField.text = ""
        generateImageButton.backgroundColor = .darkGray
        generator.requestImage(text: text) { result in
            DispatchQueue.main.async {
                self.loadingActivity.isHidden = true
                if result == true {
                    guard let image = self.generator.url else { return }
                    if let url = URL(string: image){
                        self.generatedImageView.kf.indicatorType = .activity
                        self.generatedImageView.kf.setImage(with: url)
                    }
                } else {
                    self.generatedImageView.image = nil
                    print("Erro")
                }
            }
        }
    }
}

