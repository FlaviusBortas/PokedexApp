//
//  PokemonDetailsTableViewController.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/15/18.
//

import UIKit

class PokemonDetailsTableViewController: UITableViewController {

    // MARK: - UI Elements
    @IBOutlet weak var titleLabel: UINavigationItem!
    @IBOutlet weak var idCell: UITableViewCell!
    @IBOutlet weak var expCell: UITableViewCell!
    @IBOutlet weak var heightCell: UITableViewCell!
    @IBOutlet weak var weightCell: UITableViewCell!
    @IBOutlet weak var typesCell: UITableViewCell!
    @IBOutlet weak var movesCell: UITableViewCell!
    @IBOutlet weak var spritesCell: UITableViewCell!
    
    // MARK: - Properties
    
    var pokemon: Pokemon?
    
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
        guard let pokemon = pokemon else { return }
        
        titleLabel.title = pokemon.pokemonTitle
        idCell.textLabel?.text = pokemon.idString
        expCell.textLabel?.text = pokemon.expString
        heightCell.textLabel?.text = pokemon.heightString
        weightCell.textLabel?.text = pokemon.weightString
        typesCell.textLabel?.text = ""
        movesCell.textLabel?.text = "Moves"
        spritesCell.textLabel?.text = "Images"
    }
}
