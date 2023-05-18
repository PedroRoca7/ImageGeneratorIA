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
    
    var generator = GeneratorImageManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func generateImage(_ sender: Any) {
        guard let text = descriptionImageTextField.text else { return }
        descriptionImageTextField.resignFirstResponder()
        descriptionImageTextField.text = ""
        descriptionImageTextField.backgroundColor = .darkGray
        generator.requestImage(text: text) { result in
            DispatchQueue.main.async {
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

