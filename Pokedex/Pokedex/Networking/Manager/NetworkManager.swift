//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Flavius Bortas on 10/8/18.
//

import Foundation

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String> {
    case success
    case failure(String)
}

class NetworkManager {
    let router = Router<PokemonAPI>()
    
    func getPokemon(number: Int, completion: @escaping (_ pokemon: Pokemon?, _ error: String?) -> ()) {
        router.request(.getPokemon(number)) { (data, response, error) in
            let (pokemon, error) = self.decodeTask(Pokemon.self, from: (data, response, error))
            
            completion(pokemon, error)
        }
    }

    func getPokemonImage(number: Int, completion: @escaping (_ pokemonImage: Data?, _ error: String?) -> ()) {
        router.request(.getPokemonImage(number)) { (data, response, error) in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    completion(data, nil)
                    
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            } else {
                completion(nil, "No response.")
            }
            
        }
    }
    
    private typealias NetworkResult = (data: Data?, response: URLResponse?, error: Error?)
    
    private func decodeTask<T: Decodable>(_ type: T.Type, from networkResult: NetworkResult) -> (T?, String?) {
        let (data, response, error) = networkResult
        
        if error != nil {
            return (nil, "Please check your network connection.")
        }
        
        if let response = response as? HTTPURLResponse {
            let result = self.handleNetworkResponse(response)
            
            switch result {
            case .success:
                guard let responseData = data else {
                    return (nil, NetworkResponse.noData.rawValue)
                }
                
                do {
                    let apiResponse = try JSONDecoder().decode(type, from: responseData)
                    return (apiResponse, nil)
                } catch {
                    return (nil, NetworkResponse.unableToDecode.rawValue)
                }
            case .failure(let networkFailureError):
                return (nil, networkFailureError)
            }
        }
        
        return (nil, "Failed to decode task.")
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}


