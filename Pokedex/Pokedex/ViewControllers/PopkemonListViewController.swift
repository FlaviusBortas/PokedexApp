//
//  ViewController.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/5/18.
//

import UIKit

class PokemonList: UITableViewController {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    // MARK: - Properties
    
    let networkManager = NetworkManager()
    var pokemon: PokemonResults?
    var firstGenPokemonDetails = [Pokemon]()
    var downloadGroup = DispatchGroup()
    
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemonDetails()
    }

    // MARK: - Actions
    
    
    // MARK: - Methods
    
    func getPokemonDetails() {
        for index in 1...20 {
            self.downloadGroup.enter()
            self.networkManager.getPokemon(number: index) { (pokemon, error) in
                guard let pokemon = pokemon else { return }
                
                self.firstGenPokemonDetails.append(pokemon)
                
                self.downloadGroup.leave()
            }
        }
        
        
        downloadGroup.notify(queue: .main) {
            self.firstGenPokemonDetails.sort { $0.id < $1.id }
            self.tableView.reloadData()
            
            DispatchQueue.main.async {
                self.getAllPokemonImages()
            }
        }
        
    }
    func getAllPokemonImages() {
        
        for pokemon in firstGenPokemonDetails {
            downloadGroup.enter()
            networkManager.getPokemonImage(number: pokemon.id) { (data, error) in
                pokemon.imageData = data
                self.downloadGroup.leave()
            }
        }
        
        downloadGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
}

//MARK - Cell Protocols

extension PokemonList {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return firstGenPokemonDetails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier) as! PokemonTableViewCell
        
        let pokemon = firstGenPokemonDetails[indexPath.row]
        
        cell.configure(with: pokemon)
        
        return cell
    }
}
