//
//  FileManagerServiceProtocol.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 16.10.2021.
//

import Foundation
import UIKit

protocol FileManagerServiceProtocol {
    func getImageFromCache(url: String) -> UIImage?
    func saveImageToCache(url: String, image: UIImage)
}

final class FinalManagerService: FileManagerServiceProtocol {
    func getImageFromCache(url: String) -> UIImage? {
        return UIImage()
    }

    func saveImageToCache(url: String, image: UIImage) {
        
    }


}
