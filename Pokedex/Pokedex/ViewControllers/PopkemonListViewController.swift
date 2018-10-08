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
    
    var pokemon: PokemonResults?
    
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemonData(with: pokemonURL())
        
    }

    // MARK: - Actions
    
    
    // MARK: - Methods
    
    func fetchPokemonData(with url: URL) {
        let data = pokemonData(with: url)!
        let fetchedPokemon = getPokemon(with: data)
        
        pokemon = fetchedPokemon
    }
    

}

//MARK - Cell Protocols

extension PokemonList {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let firstGen = pokemon?.firstGen else { return 0 }
        
        return firstGen.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier) as! PokemonTableViewCell
        
        guard let pokemonName = pokemon?.firstGen[indexPath.row].name else { return UITableViewCell() }
        
        cell.configure(with: pokemonName.capitalized )
        
        return cell
    }
    
    
}

extension PokemonList {
    
    // Get URL
    private func pokemonURL() -> URL {
        let defaultURL = URL(string: "https://pokeapi.co/")!
        let urlString = "https://pokeapi.co/api/v2/pokemon/"
        
        guard let url = URL(string: urlString) else { return defaultURL }
        
        return url
    }
    
    // Get Data
    private func pokemonData(with url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            print("Error!")
            return nil
        }
    }
    
    // Parse Data
    private func getPokemon(with data: Data) -> PokemonResults? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(PokemonResults.self, from: data)
            return result
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }
}

