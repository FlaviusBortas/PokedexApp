//
//  EvolutionData.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/23/18.
//

import Foundation

class EvolutionChain: Codable {
    var id: Int
    var chain: ChainLink
}

struct ChainLink: Codable {
    var species: NamedApiResource
    var evolvesTo: [ChainLink]
    
    enum CodingKeys: String, CodingKey {
        case species
        case evolvesTo = "evolves_to"
    }
}


