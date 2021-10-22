//  FileManagerService.swift
//  NetworkingProject

import UIKit

protocol ImageServiceProtocol {
    func getImage(url: URL, completion: @escaping ((UIImage)->()))
}

final class ImageService: ImageServiceProtocol{
    func getImage(url: URL, completion: @escaping ((UIImage)->())) {
        let imageAPIService = ImageAPIService()
        let fileManagerService = FileManagerService()
        let proxy = Proxy(imageAPIService: imageAPIService, fileManagerService: fileManagerService)
        
        proxy.loadImage(url: url) { result in
            completion(result)
        }
    }
}
