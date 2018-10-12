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
        
//        fetchPokemonData(with: pokemonURL())
//        getPokemonDetailsData()
//        fetchAllPokemonImages()
        
//        getAllPokemon()
        getPokemonDetails()
//        getAllPokemonImages()
        
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
//        downloadGroup = DispatchGroup()
        
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
    
//    func getAllPokemon() {
////        print(#function, "Start")
//        networkManager.getAllPokemon { pokemonResults, error in
//            if pokemonResults == nil {
////                print("**", error)
//            }
//
//            guard error == nil else {
//                print(error!)
//                return
//            }
//
//            self.pokemon = pokemonResults
//
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//
////        print(#function, "Finish")
//    }
    
//    func fetchPokemonData(with url: URL) {
//        let data = getPokemonData(for: url)!
//        let fetchedPokemon = getPokemon(with: data)
//
//        pokemon = fetchedPokemon
//    }
//
//    func getPokemonDetailsData() {
//        guard let firstGenPokemon = pokemon?.firstGen else { return }
//
//        for pokemon in firstGenPokemon {
//            guard let url = URL(string: pokemon.url) else { break }
//            let detailsData = getPokemonData(for: url)!
//            guard let fetchedPokemonDetails = getPokemonDetails(with: detailsData) else { break }
//
//            firstGenPokemonDetails.append(fetchedPokemonDetails)
//        }
//    }
//
//    func fetchAllPokemonImages() {
//        for pokemon in firstGenPokemonDetails {
//            guard let urlString = pokemon.sprites["front_default"] as? String, let url = URL(string: urlString) else { break }
//            let imageData = fetchPokemonImageData(for: url)
//
//            pokemon.imageData = imageData
//        }
//    }
//
//    func fetchPokemonImageData(for url: URL) -> Data {
//        return getPokemonData(for: url)!
//    }
}

//MARK - Cell Protocols

extension PokemonList {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let firstGen = pokemon?.firstGen else { return 0 }
        
        return firstGenPokemonDetails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier) as! PokemonTableViewCell
        
        let pokemon = firstGenPokemonDetails[indexPath.row]
        
        cell.configure(with: pokemon)
//        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
}

//extension PokemonList {
//
//    // Get URL
//    private func pokemonURL() -> URL {
//        let defaultURL = URL(string: "https://pokeapi.co/")!
//        let urlString = "https://pokeapi.co/api/v2/pokemon/"
//
//        guard let url = URL(string: urlString) else { return defaultURL }
//
//        return url
//    }
//
//    // Get Data
//    private func getPokemonData(for url: URL) -> Data? {
//        do {
//            return try Data(contentsOf: url)
//        } catch {
//            print("Error!")
//            return nil
//        }
//    }
//
//    // Parse Data
//    private func getPokemon(with data: Data) -> PokemonResults? {
//        do {
//            let decoder = JSONDecoder()
//            let result = try decoder.decode(PokemonResults.self, from: data)
//            return result
//        } catch {
//            print("JSON Error: \(error)")
//            return nil
//        }
//    }
//
//    private func getPokemonDetails(with data: Data) -> Pokemon? {
//        do {
//            let decoder = JSONDecoder()
//            let result = try decoder.decode(Pokemon.self, from: data)
//            return result
//        } catch {
//            print("JSON Error: \(error)")
//            return nil
//        }
//    }
//}

