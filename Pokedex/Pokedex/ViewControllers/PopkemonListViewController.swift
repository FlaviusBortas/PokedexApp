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
    
    var pokemonID = 1
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = pokemonData(with: pokemonURL())!
        
        let pokemon = getPokemon(with: data)
        
        print("FIRST GEN: \(pokemon?.firstGen) \n")
        print("SECOND GEN: \(pokemon?.secondGen) \n")
        print("THIRD GEN: \(pokemon?.thirdGen) \n")
        print("FOURTH GEN: \(pokemon?.fourthGen) \n")
        print("FIFTH GEN: \(pokemon?.fifthGen) \n")
        print("SIXTH GEN: \(pokemon?.sixthGen) \n")
        print("SEVENTH GEN: \(pokemon?.seventhGen) \n")

    }

    // MARK: - Actions
    
    
    // MARK: - Methods
    

}

//MARK - Cell Protocols

extension PokemonList {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier) as! PokemonTableViewCell
        
        cell.configure(with: "test")
        
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

