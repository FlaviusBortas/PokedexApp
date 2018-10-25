//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/8/18.
//

import Foundation

enum PokemonAPI {
    case getPokemon(Int)
    case getPokemonImage(Int)
    case getEvolutions(Int)
}

extension PokemonAPI: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: "https://pokeapi.co") else {
            fatalError("baseURL could not be configured.")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .getPokemon(let number):
            return "/api/v2/pokemon/\(number)"
        case .getPokemonImage(let number):
            return "/media/sprites/pokemon/\(number).png"
        case .getEvolutions(let number):
            return "/api/v2/evolution-chain/\(number)/"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
