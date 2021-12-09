//
//  ImageAPIService.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 13.10.2021.
//

import UIKit

protocol ImageAPIServiceProtocol {
    func loadImage(url: URL, handler: @escaping HandlerImage)
}

typealias HandlerImage = ((UIImage)->())

final class ImageAPIService: ImageAPIServiceProtocol {

    func loadImage(url: URL, handler: @escaping HandlerImage) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                guard let image = UIImage(data: imageData) else { return }
                handler(image)
            }
        }
    }
}
