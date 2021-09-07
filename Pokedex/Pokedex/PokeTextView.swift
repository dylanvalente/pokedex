//
//  PokeTextView.swift
//  Pokedex
//
//  Created by Daniele Valente on 07/09/21.
//

import UIKit

class PokeTextView: UITextView {
    
    init(frame: CGRect) {
        super.init(frame: frame, textContainer: nil)
        self.font = UIFont(name: "DeterminationMono", size: 16)
        self.backgroundColor = .clear
        self.textColor = .green
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
