//
//  PokeViewModel.swift
//  Pokedex
//
//  Created by Daniele Valente on 07/09/21.
//

class PokeViewModel {
    
    private var pokeAPIService : PokemonAPIService!
    private(set) var pokeData : [Pokemon]! {
        didSet {
            self.bindPokemonViewModelToController()
        }
    }
    private(set) var pokeDetailData : PokemonDetail! {
        didSet {
            self.bindPokemonDetailViewModelToController()
        }
    }
    
    var bindPokemonViewModelToController : (() -> ()) = {}
    var bindPokemonDetailViewModelToController : (() -> ()) = {}
    
    init(pokeId: String? = nil) {
        self.pokeAPIService =  PokemonAPIService()
        if let detailId = pokeId {
            callFuncToGetPokemonDetailData(pokeId: detailId)
        } else {
            callFuncToGetPokemonData()
        }
    }
    
    func callFuncToGetPokemonData() {
        self.pokeAPIService.retrievePokemonData { (pokeData) in
            self.pokeData = pokeData
        }
    }
    
    func callFuncToGetPokemonDetailData(pokeId: String) {
        self.pokeAPIService.retrievePokemonDetailData(pokeId: pokeId) { (pokeDetailData) in
            self.pokeDetailData = pokeDetailData
        }
    }
    
}
