//
//  MarvelCharacter+ObjectMapper.swift
//  MarvelCharacters
//
//  Created by Adolfo Garza on 10/10/17.
//  Copyright © 2017 Adolfo Garza. All rights reserved.
//

import Foundation

extension MarvelCharacter: ObjectMapper {
    private enum Keys: String {
        case id = "id"
        case name = "name"
        case description = "description"
        case thumbnailKey = "thumbnail"
        case pathKey = "path"
        case pathExtension = "extension"
    }
    
    convenience init(jsonMap: [String: Any]) throws {
        guard let id = jsonMap[Keys.id.rawValue] as? Int else { throw SerializationError.missing(Keys.id.rawValue)}
        guard let name = jsonMap[Keys.name.rawValue] as? String else { throw SerializationError.missing(Keys.name.rawValue)}
        guard let description = jsonMap[Keys.description.rawValue] as? String else { throw SerializationError.missing(Keys.description.rawValue)}
        guard let thumbnailDictionary = jsonMap[Keys.thumbnailKey.rawValue] as? [String:Any], let imagePath = thumbnailDictionary[Keys.pathKey.rawValue] as? String, let imageExtension = thumbnailDictionary[Keys.pathExtension.rawValue] as? String else { throw
            SerializationError.missing(Keys.thumbnailKey.rawValue)}
        let thumbnailURL = "\(imagePath).\(imageExtension)"
        
        self.init(id: String(id), name: name, description: description, thumbnail: thumbnailURL)
    }
}
