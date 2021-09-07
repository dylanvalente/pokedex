//
//  PokeTableViewCell.swift
//  Pokedex
//
//  Created by Daniele Valente on 07/09/21.
//

import UIKit

class PokeTableViewCell: UITableViewCell {
    
    var index: Int = 0
    var name: String = ""
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, index: Int) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.index = index+1
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        contentView.layer.cornerRadius = 40;
        contentView.layer.masksToBounds = true;
        contentView.backgroundColor = UIColor(red: 33.0/255.0, green: 33.0/255.0, blue: 39.0/255.0, alpha: 0.7)
        self.backgroundColor = .clear
        let pokeImage = UIImageView()
        pokeImage.downloaded(from: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(String(describing: self.index)).png")
        pokeImage.frame.size = CGSize(width: contentView.frame.height, height: contentView.frame.height)
        let pokeTextView = UITextView()
        pokeTextView.frame.size = CGSize(width: 200, height: pokeImage.frame.height-50);
        pokeTextView.frame.origin = CGPoint(x: pokeImage.frame.maxX, y: 25)
        pokeTextView.backgroundColor = UIColor(red: 155/255, green: 188/255, blue: 15/255, alpha: 1)
        pokeTextView.text = self.name
        pokeTextView.font = UIFont(name: "DeterminationMono", size: 20)
        pokeTextView.isUserInteractionEnabled = false
        let arrowTextView = UITextView()
        arrowTextView.frame.size.height = contentView.frame.size.height
        arrowTextView.frame.size.width = 50
        arrowTextView.frame.origin = CGPoint(x: pokeTextView.frame.maxX, y: 0)
        arrowTextView.backgroundColor = .clear
        arrowTextView.textColor = UIColor(red: 155/255, green: 188/255, blue: 15/255, alpha: 1)
        arrowTextView.text = ">"
        arrowTextView.font = UIFont(name: "DeterminationMono", size: 57)
        arrowTextView.isUserInteractionEnabled = false
        contentView.addSubview(pokeImage)
        contentView.addSubview(pokeTextView)
        contentView.addSubview(arrowTextView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
}
