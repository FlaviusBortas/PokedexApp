//
//  ViewController.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/5/18.
//

import UIKit

class PokemonList: UITableViewController {
    
    // MARK: - UI Elements
    
//    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var genCatagory: UISegmentedControl!
    
    // MARK: - Properties
    
    let networkManager = NetworkManager()
//    var pokemon: PokemonResults?
    var genPokemonDetails = [Pokemon]()
    var selectedPokemon: Pokemon?
    var downloadGroup = DispatchGroup()
    var generationRange = CountableRange(1...20)
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemonDetails()
    }

    // MARK: - Actions
    
    @IBAction func userSelectedGeneration(_ sender: UISegmentedControl) {
        let generation = sender.selectedSegmentIndex
        
        switch generation {
        case 0:
            generationRange = CountableRange(1...20)
            getPokemonDetails()
            tableView.reloadData()
        case 1:
            generationRange = CountableRange(152...172)
            getPokemonDetails()
            tableView.reloadData()
        case 2:
            generationRange = CountableRange(253...272)
            getPokemonDetails()
            tableView.reloadData()
        case 3:
            generationRange = CountableRange(387...407)
            getPokemonDetails()
            tableView.reloadData()
        default:
            generationRange = CountableRange(1...20)
        }
    }
    
    // MARK: - Methods
    
    func getPokemonDetails() {
        
        for index in generationRange {
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
        
        return genPokemonDetails.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier) as! PokemonTableViewCell
        
        let pokemon = genPokemonDetails[indexPath.row]
        
        cell.configure(with: pokemon)
        
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
}
