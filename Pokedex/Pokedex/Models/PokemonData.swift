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
    var moves: [PokemonMove]
    var abilities: [Abilities]
    var species: NamedApiResource
    var pokemonSpecies: PokemonSpecies?
    
    
    enum CodingKeys: String, CodingKey {
        case id, name, height, weight, sprites, types, moves, abilities, species
        case baseExperience = "base_experience"
    }

    // MARK: - Non API Related DATA
    
    var evolutions: EvolutionChain? = nil
}

    // MARK: - JSON Parsing Structure

struct NamedApiResource: Codable {
    var name: String
    var url: String
}

struct Types: Codable {
    var slot: Int
    var type: [String: String]
}

struct Abilities: Codable {
    var is_hidden: Bool
    var slot: Int
    var ability: [String: String]
}

struct PokemonMove: Codable {
    var move: NamedApiResource
}

    // MARK: - Debugging

extension Pokemon: CustomDebugStringConvertible {
    var debugDescription: String {
        return "ID: , Name: ,\n Sprites:, BaseExp:, Height: , Weight: , Types:, Moves:, Abilities:, Species: \(species)"
    }
}

extension Pokemon {
    func fetchSpeciesData(with manager: NetworkManager) {
        manager.getPokemonSpecies(for: id) { (pokemonSpecies, error) in
            self.pokemonSpecies = pokemonSpecies
        }
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
            guard let firstType = self.types.first?.type["name"] else { return " " }
            return typesString + firstType.capitalized
        case 2:
            guard let firstType = self.types.first?.type["name"] else { return " " }
            let secondType = self.types[1].type["name"]!
            
            return typesString + firstType.capitalized + ", " + secondType.capitalized
        default:
            return "No type"
        }
    }
}
