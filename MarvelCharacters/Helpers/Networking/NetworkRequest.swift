//
//  NetworkManager.swift
//  MarvelCharacters
//
//  Created by Adolfo Garza on 10/8/17.
//  Copyright © 2017 Adolfo Garza. All rights reserved.
//

import Foundation
import UIKit

enum SerializationError: Error {
    case missing(String)
}

protocol NetworkRequest: class {
    associatedtype ModelObject
    func load(withCompletion completion: @escaping (ModelObject?) -> Void)
    func decode(_ data: Data) -> ModelObject?
}

extension NetworkRequest {
    fileprivate func load(_ url: URL, withCompletion completion: @escaping (ModelObject?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                completion(self?.decode(data))
            }
        })
        task.resume()
    }
}

class APIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func load(withCompletion completion: @escaping ([Resource.ModelObject]?) -> Void) {
        if let url = resource.url {
            load(url , withCompletion: completion)
        }
    }
    
    func decode(_ data: Data) -> [Resource.ModelObject]? {
        return resource.makeModel(data: data)
    }
}

final class ImageRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

extension ImageRequest: NetworkRequest {
    
    func load(withCompletion completion: @escaping (UIImage?) -> Void) {
        if let image = AppCache.getImage(withKey: url.absoluteString) {
            completion(image)
        } else {
            load(url, withCompletion: completion)
        }
    }
    
    func decode(_ data: Data) -> UIImage? {
        let decodedImage = UIImage(data: data)
        AppCache.saveImage(withImage: decodedImage!, key: url.absoluteString)
        return decodedImage
    }
}
