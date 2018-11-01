//
//  ViewController.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/5/18.
//

import UIKit

class PokemonList: UIViewController {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var genCatagory: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingBackgroundView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    let networkManager = NetworkManager()
    var downloadGroup = DispatchGroup()
    var genPokemonDetails = [Pokemon]()
    var selectedPokemon: Pokemon?
    var selectedGeneration = Generation.one
    var filteredPokemon = [Pokemon]()
    var isSearching = false
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        getPokemonDetails()
        searchBar.returnKeyType = .done
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
        startLoading()
        
        networkManager.fetchPokemons(generation: selectedGeneration) { pokemons in
            self.stopLoading()
            self.genPokemonDetails = pokemons
            self.collection.reloadData()
        }
    }
    
    func startLoading() {
        loadingBackgroundView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        loadingBackgroundView.isHidden = true
        activityIndicator.stopAnimating()
    }
    
}

// MARK - Cell Protocols

extension PokemonList: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? filteredPokemon.count : genPokemonDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as! PokemonCollectionViewCell
        
        let pokemon = genPokemonDetails[indexPath.row]
        cell.configure(with: pokemon)
        
        isSearching ? cell.configure(with: filteredPokemon[indexPath.row]) : cell.configure(with: pokemon)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedPokemon = isSearching ? filteredPokemon[indexPath.row] : genPokemonDetails[indexPath.row]
        
        performSegue(withIdentifier: "pokemonDetails", sender: selectedPokemon)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "pokemonDetails":
            guard let pokemonDetailsVC = segue.destination as? PokemonDetailsViewController else { return }
            pokemonDetailsVC.pokemon = selectedPokemon
        default:
            print("Error")
        }
    }
}

// MARK: - SearchBar Protocols

extension PokemonList: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            collection.reloadData()
        }
        else {
            isSearching = true
            
            filteredPokemon = genPokemonDetails.filter({$0.name.contains(searchText.lowercased())})
            collection.reloadData()
        }
    }
}

// MARK: - Persistence

extension FileManager {
    static var documentDirectoryURL: URL {
        return `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}


