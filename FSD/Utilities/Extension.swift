//
//  Extension.swift
//  FlickrSearchDemo
//
//  Created by Eugen Lipatov on 22.12.2020.
//


import UIKit

//MARK:- UICollectionView
extension UICollectionView {
    func register(nib nibName: String) {
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
}

//MARK:- UIImageView
extension UIImageView {
    
    func downloadImage(_ url: String , filter: String) {
        
        ImageDownloadManager.shared.addOperation(url: url,imageView: self) {  [weak self](result,downloadedImageURL)  in
            GCD.runOnMainThread {
                switch result {
                case .Success(let image):
                    self?.image = image
                    
                    if filter != ""  {
                        
                        let inputImage = image
                        let context = CIContext(options: nil)

                        if let currentFilter = CIFilter(name:filter) {
                            let beginImage = CIImage(image: inputImage)
                            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
                            
                             if let output = currentFilter.outputImage {
                                if let cgimg = context.createCGImage(output, from: output.extent) {
                                    let processedImage = UIImage(cgImage: cgimg)
                                    self?.image = processedImage
                                }
                            }
                        }
                    }
                
                case .Failure(_):
                    break
                case .Error(_):
                    break
                }
            }
        }
    }
}
