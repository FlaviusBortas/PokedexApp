//
//  Generations.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/15/18.
//

import Foundation

enum Generation: Int {
    case one = 1
    case two
    case three
    case four
    
    var range: CountableRange<Int> {
        switch self {
        case .one:
            return CountableRange(1...151)
        case .two:
            return CountableRange(152...251)
        case .three:
            return CountableRange(252...386)
        case .four:
            return CountableRange(387...493)
        }
    }
    
    var evolutionRange: CountableRange<Int> {
        switch self {
        case .one:
            return CountableRange(1...78)
        case .two:
            return CountableRange(79...129)
        case .three:
            return CountableRange(130...202)
        case .four:
            return CountableRange(203...254)
        }
    }
}
