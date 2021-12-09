//  Created by Timofey Privalov on 16.10.2021.
//

import UIKit

typealias ImageHandler = ((UIImage)->())

protocol LoadImageProtocol {
    func loadImage(url: URL, completion: @escaping ImageHandler )
}

final class Proxy: LoadImageProtocol {
    // MARK: - Private Properties

    private let imageAPIService: ImageAPIServiceProtocol?
    private let fileManagerService: FileManagerServiceProtocol?

    init(imageAPIService: ImageAPIServiceProtocol, fileManagerService: FileManagerServiceProtocol) {
        self.imageAPIService = imageAPIService
        self.fileManagerService = fileManagerService
    }

    // MARK: - Publiv Methods
    func loadImage(url: URL, completion: @escaping ImageHandler) {
        let image = fileManagerService?.getImageFromCache(url: url.absoluteString)

        if image == nil {
            imageAPIService?.loadImage(url: url) { result in
                self.fileManagerService?.saveImageToCache(url: url.absoluteString, image: result)
                completion(result)
            }
        } else {
            guard let image = image else { return }
            completion(image)
        }
    }
}
