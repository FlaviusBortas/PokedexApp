//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/7/18.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    static let identifier = "PokemonTableViewCell"
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    func configure(with pokemon: Pokemon) {
        pokemonNameLabel.text = pokemon.name
        
        guard let imageData = pokemon.imageData else { return }
        pokemonImageView.image = UIImage(data: imageData)
    }
}
