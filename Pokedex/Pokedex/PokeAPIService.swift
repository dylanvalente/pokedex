//
//  PokeAPIService.swift
//  Pokedex
//
//  Created by Daniele Valente on 07/09/21.
//

import Foundation

class PokemonAPIService {
    
    private let pokeUrl = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151&offset=0")!
    
    func retrievePokemonData(completion : @escaping ([Pokemon]) -> ()){
        let task = URLSession.shared.dataTask(with: pokeUrl) {(data, response, error) in
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode(PokemonResponse.self, from: data)
                completion(decoded.results)
            } catch {
                print("error: ", error)
            }
        }
        task.resume()
    }
    
    
    func retrievePokemonDetailData(pokeId: String, completion : @escaping (PokemonDetail) -> ()){
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokeId)")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode(PokemonDetail.self, from: data)
                completion(decoded)
            } catch {
                print("error: ", error)
                
            }
        }
        task.resume()
    }
}
