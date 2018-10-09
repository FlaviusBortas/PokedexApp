//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/7/18.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    static let identifier = "PokemonTableViewCell"
    
    
    func configure(with name: String, imageData: Data?) {
        pokemonNameLabel.text = name
        
        guard let imageData = imageData else { return }
        pokemonImageView.image = UIImage(data: imageData)
    }
}
