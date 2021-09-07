//
//  Pokemock.swift
//  Pokedex
//
//  Created by Daniele Valente on 01/09/21.
//

struct Pokemon: Codable {
    var name: String?
    var index: Int?
}

struct PokemonResponse: Codable {
    var results: [Pokemon]
}

struct PokemonDetail: Codable {
    var name: String
    var types: [PokemonTypes]
    var stats: [PokemonStats]
}

struct PokemonTypes: Codable {
    var type: PokemonType
}

struct PokemonType: Codable {
    var name: String
}

struct PokemonStats: Codable {
    var base_stat: Int
    var stat: PokemonStat
}

struct PokemonStat: Codable {
    var name: String
}



