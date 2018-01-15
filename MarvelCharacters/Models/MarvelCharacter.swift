//
//  Character.swift
//  MarvelCharacters
//
//  Created by Adolfo Garza on 10/8/17.
//  Copyright © 2017 Adolfo Garza. All rights reserved.
//

import Foundation

final class MarvelCharacter {
    
    var id: String
    var name: String
    var description: String
    var thumbnail: String
    
    init(id: String, name: String, description: String, thumbnail: String) {
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
    }
}
