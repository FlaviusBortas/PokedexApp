//
//  PokemonMovesTableViewController.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/18/18.
//

import UIKit

class PokemonMovesTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pokemon = pokemon else { return 0 }
        
        return pokemon.moves.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonMovesTableViewCell.identifier, for: indexPath) as! PokemonMovesTableViewCell
        
        let currentIndex = indexPath.row
        
        guard let pokemon = pokemon else { return UITableViewCell() }
        
        cell.configure(with: pokemon, index: currentIndex)

        return cell
    }
 
}
