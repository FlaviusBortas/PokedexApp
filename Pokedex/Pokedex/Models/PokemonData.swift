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
    var baseExperience: Int
    var height: Int
    var weight: Int
    var sprites: [String: String?]
    var types: [Types]
    var moves: [Moves]

    enum CodingKeys: String, CodingKey {
        case id, name, height, weight, sprites, types, moves
        case baseExperience = "base_experience"
    }
    
    // Non API related DATA
    
    var imageData: Data? = nil
}

struct Types: Codable {
    var slot: Int
    var type: [String: String]
}

struct Moves: Codable {
    var move: [String: String]
}

extension Pokemon: CustomDebugStringConvertible {
    var debugDescription: String {
        return "ID: \(id) Name: \(name),\n Sprites: \(sprites), BaseExp: \(baseExperience), Height: \(height), Weight: \(weight), Types: \(types), Moves: \(moves)"
    }
}
