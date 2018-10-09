//
//  PokemonData.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/5/18.
//

import Foundation

class Pokemon: Codable {
    var id: Int
    var name: String
    var sprites: [String: String?]
    var imageData: Data? = nil
}

extension Pokemon: CustomDebugStringConvertible {
    var debugDescription: String {
        return "ID: \(id) Name: \(name),\n Sprites: \(sprites)"
    }
}
