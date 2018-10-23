//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/15/18.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    // MARK: - UI Elements

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var expLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nextEvolution: UIImageView!
    @IBOutlet weak var nextEvolution2: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    // MARK: - Properties
    
    let networkManager = NetworkManager()
    var pokemon: Pokemon?

    // MARK: - View LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        loadDetails()
        setTabBarImage()
    }
    
    // MARK: - Actions
    
    @IBAction func segmentClicked(_ sender: Any) {
        tableView.reloadData()
    }
    
    @IBAction func shinySwitch(_ sender: UISwitch) {
        guard let pokemon = pokemon else { return }

        if sender.isOn {
            pokemonImageView.image = UIImage(named: "\(pokemon.name)")
        }
        else {
            pokemonImageView.image = UIImage(named: "\(pokemon.id)")
        }
    }
    
    // MARK: - Methods
    
    func loadDetails() {
        
        guard let pokemon = self.pokemon else { return }
        
        pokemonImageView.image = UIImage(named: "\(pokemon.id).png")
        titleLabel.text = pokemon.pokemonTitle
        idLabel.text = pokemon.idString
        expLabel.text = pokemon.expString
        heightLabel.text = pokemon.heightString
        weightLabel.text = pokemon.weightString
        typeLabel.text = pokemon.typeString
    }
    
    func setTabBarImage() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "PokedexSearchBarBG"), for: .default)
    }
}

    // MARK: - Cell Protocols

extension PokemonDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let moves = pokemon?.moves, let abilities = pokemon?.abilities else { return 0 }
        
        return segment.selectedSegmentIndex == 0 ? moves.count :  abilities.count
    }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonMovesTableViewCell.identifier, for: indexPath) as! PokemonMovesTableViewCell
        let currentIndex = indexPath.row
        
        guard let pokemon = pokemon else { return UITableViewCell() }
        
        cell.configure(with: pokemon, index: currentIndex)
        
        return cell
    }
}
