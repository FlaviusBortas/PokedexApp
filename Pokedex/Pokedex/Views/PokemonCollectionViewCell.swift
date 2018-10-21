//
//  PokemonCollectionViewCell.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/20/18.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    static let identifier = "PokemonCell"
    
    func configure(with pokemon: Pokemon) {
        pokemonNameLabel.text = pokemon.name.capitalized
        
//        guard let imageData = pokemon.imageData else { return }
        pokemonImageView.image = UIImage(named: "\(pokemon.id).png")
        
//        pokemonImageView.loadGif(name: "\(pokemon.id)")
    }
}
