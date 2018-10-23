//
//  EvolutionData.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/23/18.
//

import Foundation

struct EvolutionData: Codable {
    
//    var chain: [String: String?]
//    var evolvesTo: [[String: String?]]
//    var evolutionDetails: [String: String?]
    var secondEvo: [String: String?]
    var thirdEvo: [String: String?]

    
    enum CodingKeys: String, CodingKey {
        case chain
        case evolvesTo = "evolves_to"
        case evolution = "species"
        case evolutionDetails = "evolution_details"
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let chainContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .chain)
        let evolvesToContainer = try chainContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .evolvesTo)
        // Breaks here
        let evolvesToContainer2 = try evolvesToContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .evolvesTo)
        secondEvo = try evolvesToContainer2.decode([String: String?].self, forKey: .evolution)
        let evolutionDetails = try evolvesToContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .evolutionDetails)
        thirdEvo = try evolutionDetails.decode([String: String?].self, forKey: .evolution)

    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.secondEvo, forKey: .evolution)
        try container.encode(self.thirdEvo, forKey: .evolution)

    }
}
