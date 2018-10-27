//
//  PokemonMovesTableViewCell.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/18/18.
//

import UIKit

class PokemonMovesTableViewCell: UITableViewCell {

    static let identifier = "PokemonMovesCell"
    
    @IBOutlet weak var pokemonMovesLabel: UILabel!
    
    func configure(with pokemon: Pokemon, index: Int) {
        pokemonMovesLabel.text = pokemon.moves[index].move.name
        
    }

}
