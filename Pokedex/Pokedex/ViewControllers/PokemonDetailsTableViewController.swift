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
    
    // MARK: - Properties
    
    var pokemon: Pokemon?

    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDetails()
        setTabBarImage()
    }
    
    // MARK: - Actions
    
    
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
//        movesCell.textLabel?.text = "Moves"
//        spritesCell.textLabel?.text = "Images"
    }
    
//    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        self.selectedPokemon = pokemon?.moves[indexPath.row]
//
//        return indexPath
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "pokemonMoves":
            guard let pokemonMovesVC = segue.destination as? PokemonMovesTableViewController else { return }
            pokemonMovesVC.pokemon = pokemon
        default:
            print("Error")
        }
    }
    
    func setTabBarImage() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "PokedexSearchBarBG"), for: .default)
    }
}
