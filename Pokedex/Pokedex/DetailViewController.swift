//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Daniele Valente on 04/09/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var pokeId: String = ""
    private var pokeViewModel : PokeViewModel!
    private var nameTextView: UITextView!
    private var typesTextView: UITextView!
    private var backgroundView: UIView!
    
    override func viewDidLoad() {
        //immagine del pokemon
        let detailImageView = UIImageView()
        detailImageView.downloaded(from:  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokeId).png")
        if UIDevice.current.userInterfaceIdiom == .pad {
            detailImageView.frame.size = CGSize(width: self.view.frame.width/2, height: self.view.frame.height/2)
        } else {
            detailImageView.frame.size = CGSize(width: self.view.frame.width-20, height: self.view.frame.width-20)
        }
        detailImageView.frame.origin = CGPoint(x: 10, y: 10)
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView)
        self.view.addSubview(detailImageView)
        
        //view che contiene info e statistiche
        self.backgroundView = UIView(frame: CGRect(
                                        x: 0,
                                        y: detailImageView.frame.maxY,
                                        width: self.view.frame.width,
                                        height: self.view.frame.height - detailImageView.frame.height))
        backgroundView.backgroundColor = .black.withAlphaComponent(0.7)
        self.view.addSubview(backgroundView)
        
        //textView del nome
        self.nameTextView = PokeTextView(frame: CGRect(x: 15, y: 10, width: backgroundView.frame.width, height: 30))
        backgroundView.addSubview(nameTextView)
        
        //textView dei tipi
        self.typesTextView = PokeTextView(frame: CGRect(x: 15, y: nameTextView.frame.maxY, width: self.view.frame.width, height: 30))
        backgroundView.addSubview(typesTextView)
        
        //view model
        self.pokeViewModel = PokeViewModel(pokeId: self.pokeId)
        self.pokeViewModel.bindPokemonDetailViewModelToController = {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    private func updateViews() {
        //valorizzo nome
        nameTextView.text = "Name: \(self.pokeViewModel.pokeDetailData.name)"
        //valorizzo tipi
        let types = self.pokeViewModel.pokeDetailData.types.map({item in item.type.name})
        typesTextView.text = "Types: \(types[0])"
        for (index, type) in types.enumerated() {
            if index != 0 {
                typesTextView.text.append(", \(type)")
            }
        }
        //creo e valorizzo stats
        var initialY: CGFloat = typesTextView.frame.maxY
        let statsNameValueTupleArray = self.pokeViewModel.pokeDetailData.stats.map({item in (name: item.stat.name, value: item.base_stat)})
        for nameValue in statsNameValueTupleArray {
            let statTextView = PokeTextView(frame: CGRect(x: 15, y: initialY, width: self.view.frame.width, height: 30))
            statTextView.text = "\(nameValue.name): \(nameValue.value)"
            backgroundView.addSubview(statTextView)
            initialY = statTextView.frame.maxY
        }
    }
}
