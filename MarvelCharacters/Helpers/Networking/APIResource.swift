//
//  APIEndpoint.swift
//  MarvelCharacters
//
//  Created by Adolfo Garza on 10/10/17.
//  Copyright © 2017 Adolfo Garza. All rights reserved.
//

import Foundation
import CryptoSwift

protocol ObjectMapper {
    init(jsonMap: [String: Any]) throws
}

protocol APIResource {
    associatedtype ModelObject: ObjectMapper
    var endpointPath: String { get }
}

extension APIResource {
    private var ts: String {
        return NSDate().timeIntervalSince1970.description
    }
    
    var url: URL? {
        let publicKey = "YOUR PUBLIC KEY"
        let privateKey = "YOUR PRIVATE KEY"
        let baseURL = "http://gateway.marvel.com/v1/public"
        let tsParameter = "ts="
        let apiKeyParameter = "apikey="
        let hashParameter = "hash="
        let tsValue = ts
        let hashValue = "\(tsValue)\(privateKey)\(publicKey)".md5()
        let completeURL = "\(baseURL)\(endpointPath)?\(tsParameter)\(tsValue)&\(apiKeyParameter)\(publicKey)&\(hashParameter)\(hashValue)"
        return URL(string:completeURL)
    }
    
    func makeModel(data: Data) -> [ModelObject]? {
        do {
            guard let jsonResponseDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return nil }
            var models: [ModelObject] = []
            for element in (try APIWrapper(jsonMap: jsonResponseDictionary)).responseData {
                do {
                    models.append(try ModelObject(jsonMap: element))
                } catch {
                    print(error.localizedDescription)
                }
            }
            return models
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

struct CharactersResource: APIResource {
    typealias ModelObject = MarvelCharacter
    var endpointPath = "/characters"
}


