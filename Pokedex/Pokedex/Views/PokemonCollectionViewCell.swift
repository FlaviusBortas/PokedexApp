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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        layer.borderWidth = 2
//        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 12
//        layer.backgroundColor = UIColor.lightGray.cgColor
    }
    
    func configure(with pokemon: Pokemon) {
        pokemonNameLabel.text = pokemon.name.capitalized
        
        pokemonImageView.image = UIImage(named: "\(pokemon.name)R.png")
    }
}
