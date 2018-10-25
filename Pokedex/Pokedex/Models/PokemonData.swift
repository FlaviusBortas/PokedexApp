//
//  PokemonData.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/5/18.
//

import Foundation

    // MARK: - API Data Structure

class Pokemon: Codable {
    
    var id: Int
    var name: String
    var baseExperience: Int
    var height: Int
    var weight: Int
    var sprites: [String: String?]
    var types: [Types]
    var moves: [Moves]
    var abilities: [Abilities]
    
    enum CodingKeys: String, CodingKey {
        case id, name, height, weight, sprites, types, moves, abilities
        case baseExperience = "base_experience"
    }

    // MARK: - Non API Related DATA
    
    var evolutions: EvolutionData? = nil
}

    // MARK: - JSON Parsing Structure

struct Types: Codable {
    var slot: Int
    var type: [String: String]
}

struct Abilities: Codable {
    var is_hidden: Bool
    var slot: Int
    var ability: [String: String]
}

struct Moves: Codable {
    var move: [String: String]
}

    // MARK: - Debugging

extension Pokemon: CustomDebugStringConvertible {
    var debugDescription: String {
        return "ID: , Name: ,\n Sprites:, BaseExp:, Height: , Weight: , Types:, Moves: \(moves), Abilities: \(abilities)"
    }
}

    // MARK: - Computed Properties

extension Pokemon {
    
    var pokemonTitle: String {
        return "\(self.name)".capitalized
    }
    
    var idString: String {
        return "ID: \(self.id)"
    }
    
    var expString: String {
        return "EXP: \(self.baseExperience)"
    }
    
    var heightString: String {
        let formattedHeight = String(format: "%0.01f", Double(self.height)/10)
        
        return "Height: \(formattedHeight) m"
    }
    
    var weightString: String {
        let formattedWeight = String(format: "%0.01f", Double(self.weight)/10)
        
        return "Weight: \(formattedWeight) kg"
    }
    
    var typeString: String {
        let typesString = "Type: "
        
        switch self.types.count {
        case 1:
            let firstType = self.types[0].type["name"]!
            return typesString + firstType.capitalized
        case 2:
            let firstType = self.types[0].type["name"]!
            let secondType = self.types[1].type["name"]!
            
            return typesString + firstType.capitalized + ", " + secondType.capitalized
        default:
            return "No type"
        }
    }
}
