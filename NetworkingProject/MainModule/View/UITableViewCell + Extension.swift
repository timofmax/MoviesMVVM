//
//  UITableViewCell + Extension.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 16.10.2021.
//

import UIKit

extension UITableViewCell {
    func loadImage(path: String?, imageView: UIImageView?) {
        var staticPath = "https://image.tmdb.org/t/p/w500/"
        guard let path = path,
              let url = URL(string: staticPath + path) else { return }
        let imageService = ImageService()

        imageService.getImage(url: url) { [ weak self] result in
            imageView?.image = result
        }
    }


    func loadAPIImage(url: URL) -> UIImage? {
        let imageAPIService = ImageAPIService()
        var image: UIImage?
        imageAPIService.loadImage(url: url) { result in
            image = result
        }
        return image
    }
}


/*
 imageAPIService.downloadDetailedMovies(id: id) { movieFromInternet in
     let basePosterUrlString = "https://image.tmdb.org/t/p/w500"
     let backColorView = UIView()
     backColorView.backgroundColor = .clear
     self.titleLabel.text = movieFromInternet.originalTitle
//            let trailLink = movieFromInternet.backdropPath
     let trailLink = movieFromInternet.backdropPath
     guard let tryLink = trailLink else { return }
     guard let url = URL(string: basePosterUrlString + tryLink ?? "/3KwAmIKMaDcBMonF5wmyNTL0SR6.jpg") else { return }
     guard let imageData = try? Data(contentsOf: url) else { return }
     self.posterImageView.image = UIImage(data: imageData)
 }
 */
