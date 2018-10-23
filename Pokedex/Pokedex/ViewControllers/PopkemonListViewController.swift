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
        setTabBarImage()
        getPokemonDetails()
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.endEditing(true)
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
            self.collection.reloadData()
            
//            DispatchQueue.main.async {
//                self.getAllPokemonImages()
//            }
        }
    }
    
//    func getAllPokemonImages() {
//
//        for pokemon in genPokemonDetails {
//            downloadGroup.enter()
//            networkManager.getPokemonImage(number: pokemon.id) { (data, error) in
//                pokemon.imageData = data
//                self.downloadGroup.leave()
//            }
//        }
//
//        downloadGroup.notify(queue: .main) {
//            self.collection.reloadData()
//        }
//    }
}

    // MARK - Cell Protocols

extension PokemonList: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isSearching {
            return filteredPokemon.count
        }
        else {
            return genPokemonDetails.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as! PokemonCollectionViewCell
        
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
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPokemon = genPokemonDetails[indexPath.row]
        
        performSegue(withIdentifier: "pokemonDetails", sender: selectedPokemon)
        print(selectedPokemon)
//        print("Selected Pokemon: \(selectedPokemon!)")
    }
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        if isSearching {
//            return filteredPokemon.count
//        }
//
//        return genPokemonDetails.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier) as! PokemonTableViewCell
//
//        let pokemon = genPokemonDetails[indexPath.row]
//
//        cell.configure(with: pokemon)
//
//        if isSearching {
//            cell.configure(with: filteredPokemon[indexPath.row])
//        }
//        else {
//            cell.configure(with: pokemon)
//        }
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        self.selectedPokemon = genPokemonDetails[indexPath.row]
//
//        return indexPath
//    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "pokemonDetails":
            guard let pokemonDetailsVC = segue.destination as? PokemonDetailsViewController else { return }
            print(selectedPokemon)
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
            view.endEditing(true)
            collection.reloadData()
        }
        else {
            isSearching = true
            
            filteredPokemon = genPokemonDetails.filter({$0.name.contains(searchText.lowercased())})
            collection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func setTabBarImage() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "PokedexSearchBarBG"), for: .default)
    }
}
