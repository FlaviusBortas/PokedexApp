//
//  ViewController.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/5/18.
//

import UIKit

class PokemonList: UITableViewController, UISearchBarDelegate {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var genCatagory: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    
    let networkManager = NetworkManager()
    var genPokemonDetails = [Pokemon]()
    var selectedPokemon: Pokemon?
    var downloadGroup = DispatchGroup()
    var selectedGeneration = Generation.one
    var filteredPokemon = [Pokemon]()
    var isSearching = false
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemonDetails()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
    }

    // MARK: - Actions
    
    @IBAction func userSelectedGeneration(_ sender: UISegmentedControl) {
        guard let generation = Generation(rawValue: sender.selectedSegmentIndex + 1) else { return }
        
        genPokemonDetails.removeAll()
        selectedGeneration = generation
        getPokemonDetails()
    }
    
    // MARK: - Methods
    
    func getPokemonDetails() {
        for index in selectedGeneration.range {
            self.downloadGroup.enter()
            self.networkManager.getPokemon(number: index) { (pokemon, error) in
                guard let pokemon = pokemon else { return }
                
                self.genPokemonDetails.append(pokemon)
                
                self.downloadGroup.leave()
            }
        }
        
        downloadGroup.notify(queue: .main) {
            self.genPokemonDetails.sort { $0.id < $1.id }
            self.tableView.reloadData()
            
            DispatchQueue.main.async {
                self.getAllPokemonImages()
            }
        }
    }
    
    func getAllPokemonImages() {
        
        for pokemon in genPokemonDetails {
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
        
        if isSearching {
            return filteredPokemon.count
        }
        
        return genPokemonDetails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier) as! PokemonTableViewCell
        
        let pokemon = genPokemonDetails[indexPath.row]
        
        cell.configure(with: pokemon)
        
        if isSearching {
            cell.configure(with: filteredPokemon[indexPath.row])
        }
        else {
            cell.configure(with: pokemon)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedPokemon = genPokemonDetails[indexPath.row]
        
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "pokemonDetails":
            guard let pokemonDetailsVC = segue.destination as? PokemonDetailsTableViewController else { return }
            pokemonDetailsVC.pokemon = selectedPokemon
        default:
            print("Error")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }
        else {
            isSearching = true
            
            filteredPokemon = genPokemonDetails.filter({$0.name.contains(searchText.lowercased())})
            tableView.reloadData()
        }
    }
    
}
