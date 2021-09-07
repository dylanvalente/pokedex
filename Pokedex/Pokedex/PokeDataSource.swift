//
//  PokeDataSource.swift
//  Pokedex
//
//  Created by Daniele Valente on 07/09/21.
//

import Foundation
import UIKit

class PokeTableViewDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier : String!
    private var items : [Pokemon]!
    var configureCell : (PokeTableViewCell, Pokemon) -> () = {_,_ in }
    
    
    init(cellIdentifier : String, items : [Pokemon], configureCell : @escaping (PokeTableViewCell, Pokemon) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.items[indexPath.row]
        let pokeCell = PokeTableViewCell(style: .default, reuseIdentifier: "PokeTableViewCell", index: indexPath.item)
        pokeCell.selectionStyle = .none
        self.configureCell(pokeCell, item)
        return pokeCell
    }
    
}
