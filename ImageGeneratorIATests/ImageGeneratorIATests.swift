//
//  ImageGeneratorIATests.swift
//  ImageGeneratorIATests
//
//  Created by Pedro Henrique on 18/05/23.
//

import XCTest
@testable import ImageGeneratorIA

class ImageGeneratorIATests: XCTestCase {
    
    var viewModel = GeneratorImageViewModel()
    
    func testSeServicoRetornarOk() {
        viewModel.api = APIMock(fail: false)
        viewModel.requestImage(text: "")
        
        XCTAssertEqual(viewModel.testApiMock, "Ok")
    }
    
    func testSeServicoRetornarErro() {
        viewModel.api = APIMock(fail: true)
        viewModel.requestImage(text: "")
        
        XCTAssertEqual(viewModel.testApiMock, "Erro")
    }
}


