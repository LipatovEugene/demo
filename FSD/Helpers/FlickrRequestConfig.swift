//
//  FlickrRequestConfig.swift
//  FlickrSearchDemo
//
//  Created by Eugen Lipatov on 22.12.2020.
//


import UIKit

enum FlickrRequestConfig {
    
    case searchRequest(String, Int)
    
    var value: Request? {
        
        switch self {
            
        case .searchRequest(let searchText, let pageNo):
            let urlString = String(format: Constants.searchURL, searchText, pageNo)
            
            print("Select urk string")
            let reqConfig = Request.init(requestMethod: .get, urlString: urlString)
            return reqConfig
        }
    }
}
