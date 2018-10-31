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
    @IBOutlet weak var nextEvolution3: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    // MARK: - Properties
    
    let networkManager = NetworkManager()
    var pokemon: Pokemon?
    var firstForm: String?
    var secondForm: String?
    var thirdForm: String?

    // MARK: - View LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let pokemon = pokemon else { return }
        
        if let speciesId = pokemon.pokemonSpecies?.speciesId {
            getEvolutions(for: speciesId)
        }
        
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
            
            guard let firstForm = firstForm else { return }
            nextEvolution.image = UIImage(named: firstForm)
            
            guard let secondForm = secondForm else { return }
            nextEvolution2.image = UIImage(named: secondForm)
            
            guard let thirdForm = thirdForm else { return }
            nextEvolution3.image = UIImage(named: thirdForm)
        }
        else {
            pokemonImageView.image = UIImage(named: "\(pokemon.name)R.png")
            
            guard let firstForm = firstForm else { return }
            nextEvolution.image = UIImage(named: "\(firstForm)R.png")
            
            guard let secondForm = secondForm else { return }
            nextEvolution2.image = UIImage(named: "\(secondForm)R.png")
            
            guard let thirdForm = thirdForm else { return }
            nextEvolution3.image = UIImage(named: "\(thirdForm)R.png")
            
        }
    }
    
    // MARK: - Methods
    
    func getEvolutions(for pokemon: Int) {
        networkManager.getPokemonEvolutions(speciesNumber: pokemon) { (evolutions, error) in
            guard let evolutions = evolutions else { return }
            
            DispatchQueue.main.async {
                
                let firstForm = evolutions.chain
                self.firstForm = firstForm.species.name
                self.nextEvolution.image = UIImage(named: "\(firstForm.species.name)R.png")
                
                guard let secondForm = firstForm.evolvesTo.first else { return }
                self.secondForm = secondForm.species.name
                self.nextEvolution2.image = UIImage(named: "\(secondForm.species.name)R.png")
                
                guard let thirdFrom = secondForm.evolvesTo.first else { return }
                self.thirdForm = thirdFrom.species.name
                self.nextEvolution3.image = UIImage(named: "\(thirdFrom.species.name)R.png")
            }

        }
    }
    
    func loadDetails() {
        
        guard let pokemon = self.pokemon else { return }
        
        pokemonImageView.image = UIImage(named: "\(pokemon.name)R.png")
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
