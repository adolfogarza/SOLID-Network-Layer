//
//  AppCache.swift
//  MarvelCharacters
//
//  Created by Adolfo Garza on 10/15/17.
//  Copyright © 2017 Adolfo Garza. All rights reserved.
//

import Foundation
import UIKit

final class AppCache {
    static let sharedImageCache = NSCache<NSString, AnyObject>()
    
    static func saveImage(withImage image: UIImage, key: String) {
        sharedImageCache.setObject(image, forKey: key as NSString)
    }
    
    static func getImage(withKey key: String) -> UIImage? {
        return sharedImageCache.object(forKey: key as NSString) as? UIImage
    }
}
