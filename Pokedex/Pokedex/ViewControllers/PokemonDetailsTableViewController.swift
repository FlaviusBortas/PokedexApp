//
//  PokemonDetailsTableViewController.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/15/18.
//

import UIKit

class PokemonDetailsTableViewController: UITableViewController {

    // MARK: - UI Elements
    @IBOutlet weak var idCell: UITableViewCell!
    @IBOutlet weak var expCell: UITableViewCell!
    @IBOutlet weak var heightCell: UITableViewCell!
    @IBOutlet weak var weightCell: UITableViewCell!
    @IBOutlet weak var spritesCell: UITableViewCell!
    @IBOutlet weak var titleLabel: UINavigationItem!
    
    // MARK: - Properties
    
    var pokemon: Pokemon?
    
    var pokemonTitle: String {
        guard let pokemon = pokemon else { return "No pokemon" }
        return "\(pokemon.name)".capitalized
    }
    
    var id: String {
        guard let pokemon = pokemon else { return "No pokemon" }
        return "ID: \(pokemon.id)"
    }
    
    var exp: String {
        guard let pokemon = pokemon else { return "No pokemon" }
        return "EXP: \(pokemon.baseExperience)"
    }
    
    var height: String {
        guard let pokemon = pokemon else { return "No pokemon" }
        let formattedHeight = String(format: "%0.01f", Double(pokemon.height)/10)
        
        return "Height: \(formattedHeight) m"
    }
    
    var weight: String {
        guard let pokemon = pokemon else { return "No pokemon" }
         let formattedWeight = String(format: "%0.01f", Double(pokemon.weight)/10)
        
        return "Weight: \(formattedWeight) kg"
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        loadDetails()
    }
    
    // MARK: - Methods
    
    func loadDetails() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        titleLabel.title = pokemonTitle
        idCell.textLabel?.text = id
        expCell.textLabel?.text = exp
        heightCell.textLabel?.text = height
        weightCell.textLabel?.text = weight
        spritesCell.textLabel?.text = "Images"
    }
}
