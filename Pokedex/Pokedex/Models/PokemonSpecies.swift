//
//  PokemonSpecies.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/27/18.
//

import Foundation

struct PokemonSpecies: Codable {
    let name: String
    let evolvesFromSpecies: NamedApiResource?
    let evolutionChain: ApiResource
    
    enum CodingKeys: String ,CodingKey {
        case name
        case evolvesFromSpecies = "evolves_from_species"
        case evolutionChain = "evolution_chain"
    }
}

struct ApiResource: Codable {
    let url: String
}

extension PokemonSpecies {
    var speciesId: Int {
        
        let speciecIdString = Array(evolutionChain.url.split(separator: "/").last!)
            .map { String($0) }
            .joined()
        
        return Int(speciecIdString)!
    }
}
