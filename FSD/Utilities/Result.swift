//
//  Result.swift
//  FlickrSearchDemo
//
//  Created by Eugen Lipatov on 22.12.2020.
//


import UIKit

enum Result <T>{
    case Success(T)
    case Failure(String)
    case Error(String)
}
