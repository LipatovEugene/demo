//
//  FlickrPhoto.swift
//  FlickrSearch
//
//  Created by Eugen Lipatov on 22.12.2020.
//
import UIKit

struct FlickrPhoto: Codable {
    
    let farm : Int
    let id : String
    let secret : String
    let server : String
   
    var imageURL: String {
        let urlString = String(format:Constants.imageURL, farm, server, id, secret)
        return urlString
    }
}
