//
//  EvolutionData.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/23/18.
//

import Foundation

class Evolutions: Codable {
    var chain: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case chain
    }
}

extension Evolutions: CustomDebugStringConvertible {
    var debugDescription: String {
        return "Evolutions:"
    }
}
