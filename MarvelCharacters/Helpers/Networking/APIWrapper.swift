//
//  MarvelAPIWrapper.swift
//  MarvelCharacters
//
//  Created by Adolfo Garza on 10/10/17.
//  Copyright © 2017 Adolfo Garza. All rights reserved.
//

import Foundation

struct APIWrapper {
    let responseData: [[String: Any]]
}

extension APIWrapper: ObjectMapper {
    private enum Keys: String {
        case dataKey = "data"
        case resultsKey = "results"
    }
    
    init(jsonMap: [String : Any]) throws {
        guard let charactersFullResponse = jsonMap[Keys.dataKey.rawValue] as? [String: Any] else { throw SerializationError.missing(Keys.dataKey.rawValue) }
        guard let charactersArray = charactersFullResponse[Keys.resultsKey.rawValue] as? [[String: Any]] else {throw SerializationError.missing(Keys.resultsKey.rawValue)}
        self.responseData = charactersArray
    }
}
