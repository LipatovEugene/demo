//
//  Utility.swift
//  FlickrSearchDemo
//
//  Created by Eugen Lipatov on 22.12.2020.
//


import UIKit

class GCD {
    
    static func runAsynch(closure: @escaping () -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            closure()
        }
    }
    
    static func runOnMainThread(closure: @escaping () -> Void) {
        DispatchQueue.main.async {
            closure()
        }
    }
}
