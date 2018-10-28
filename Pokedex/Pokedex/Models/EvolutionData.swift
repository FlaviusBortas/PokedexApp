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
//struct Species: Codable {
//    var name: String
//}

//struct EvolutionData: Codable {
//
//    var evolution: Evolution
//
//    enum CodingKeys: String, CodingKey {
//        case chain
//        case evolution = "species"
//    }
//
//    struct EvolvesToFirstLevel: Codable {
//        var name: String
//    }
//
//    struct EvolvesToSecondLevel: Codable {
//        var name: String
//    }
//
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        if container.contains(.chain) {
//            evolution = try container.decode(Evolution.self, forKey: .chain)
//        } else {
//            evolution = try Evolution(from: decoder)
//        }
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(self.evolution, forKey: .evolution)
//
//    }
//}

