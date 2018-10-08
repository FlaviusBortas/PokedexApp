//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/7/18.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    static let identifier = "PokemonTableViewCell"
    
    
    func configure(with name: String) {
        pokemonNameLabel.text = name
    }
}
