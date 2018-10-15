//
//  PokemonEndpoint.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/7/18.
//

import Foundation


struct PokemonResults: Codable {
    struct PokemonEndpoint: Codable {
        let name: String
        let url: String
    }
    
    var results: [PokemonEndpoint]
    
    lazy var firstGen: [PokemonEndpoint] = {
        return Array(results[0..<21])
    }()
}

extension PokemonResults {
    
    var secondGen: [PokemonEndpoint] {
        return Array(results[151..<251])
    }
    
    var thirdGen: [PokemonEndpoint] {
        return Array(results[251..<386])
    }
    
    var fourthGen: [PokemonEndpoint] {
        return Array(results[386..<493])
    }
    
    var fifthGen: [PokemonEndpoint] {
        return Array(results[493..<649])
    }
    
    var sixthGen: [PokemonEndpoint] {
        return Array(results[649..<721])
    }
    
    var seventhGen: [PokemonEndpoint] {
        return Array(results[721..<802])
    }
}
